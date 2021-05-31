require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'returns valid if all the fields are properly filled out' do
      @category = Category.new name: 'Electronics'
      @product = Product.new name: 'Playstation 4 Pro', price: 260, quantity: 12, category: @category
      expect(@product).to be_valid
    end
    # validates: name, presence: true
    it 'does not return valid if the product name is empty' do
      @category = Category.new name: 'Electronics'
      @product = Product.new name: nil, price: 260, quantity: 12, category: @category
      expect(@product).to_not be_valid
    end

    # validates :price, presenc: true
    it 'does not return valid if the product price is empty' do
      @category = Category.new name: 'Electronics'
      @product = Product.new name: 'Playstation 4 Pro', price: nil, quantity: 12, category: @category
      expect(@product).to_not be_valid
    end
    # validates :quantity, presence: true
    it 'does not return valid if the product quantity is empty' do
      @category = Category.new name: 'Electronics'
      @product = Product.new name: 'Playstation 4 Pro', price: 260, quantity: nil, category: @category
      expect(@product).to_not be_valid
    end
    # validates :category, presence: true
    it 'does not return valid if the product category is empty' do
      @category = Category.new name: 'Electronics'
      @product = Product.new name: 'Playstation 4 Pro', price: 260, quantity: 12, category: nil
      expect(@product).to_not be_valid
    end
  end
end
