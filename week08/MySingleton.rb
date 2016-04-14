class Object
  def singleton_class
    class << self
      self
    end
  end

  def define_singleton_method(method_name, &block)
    singleton_class.send(:define_method, method_name, &block)
  end
end

class String
  def to_proc
    proc do |arg|
      split(".").each { |method| arg = arg.public_send(method) }
      arg
    end
  end
end

class Module

  private

    def private_attr_reader(*getter_name)
      getter_name.each do |name|
        define_method(name) { instance_variable_get("@#{name}") }
      end
    end

    def private_attr_writter(*setter_name)
      setter_name.each do |name|
        define_method("#{name}=") { |value| instance_variable_set("@#{name}", value) }
      end
    end

    def private_attr_accessor(*accessor_name)
      accessor_name.each do |name|
        private_attr_reader(name)
        private_attr_writter(name)
      end
    end

  public

  def cattr_reader(*getter_name, &block)
    singleton_class.class_eval do
      getter_name.each do |name|
       define_method(name) do
          class_variable_set("@@#{name}", block.call) if block
          class_variable_get("@@#{name}")
        end
      end
    end
  end

  def cattr_writter(*setter_name, &block)
    singleton_class.class_eval do
      setter_name.each do |name|

       define_method("#{name}=") do |value|
        if block
          class_variable_set("@@#{name}", block.call)
        else
          class_variable_set("@@#{name}", value)
        end
       end
      end
    end
  end

  def cattr_accessor(*accessor_name, &block)
    accessor_name.each do |name|
      cattr_reader(name, &block)
      cattr_writter(name, &block)
    end
  end

end

class NilClass
  def method_missing(*)
    nil
  end
end

class Proxy
  def initialize(arg)
    @arg = arg
  end

  def method_missing(method)
    @arg.send(method)
  end

  def respond_to_missing?(method, *)
    @arg.respond_to? :method
  end
end

class Object
  def delegate(methоd_name, to:)
    class_eval <<-RUBY
      def #{methоd_name}(*args, &block)
        #{to}.#{methоd_name}(*args, &block)
      end
      RUBY
  end
end

User = Struct.new(:first_name, :last_name)

class Invoice
  delegate :first_name, to: '@user'
  delegate :last_name, to: '@user'

  def initialize(user)
    @user = user
  end
end

user = User.new 'Genadi', 'Samokovarov'
invoice = Invoice.new(user)

p invoice.first_name #=> "Genadi"
p invoice.last_name #=> "Samokovarov"