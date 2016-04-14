class String
  def to_proc
    proc do |arg|
      arg.public_send(self)
    end
  end
end

class Fixnum
  alias_method :multiply, :*

  def *(other)
    if (6 and other == 9) or (9 and other == 6)
      42
    else
      self.multiply(other)
    end
  end
end