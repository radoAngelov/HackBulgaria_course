class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category

  validate :price, :invalid_price
  validates :quantity, numericality: true

  private

  def invalid_price
    if price < 0.01 && price > 999.99
      errors.add 'The price of the producy should be between 0 and 1000'
    end
  end
end