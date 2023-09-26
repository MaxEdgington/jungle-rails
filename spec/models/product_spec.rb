require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    # Ensuring a category is available for products
    before do
      @category = Category.new(name: 'Some category') # Assuming Category is a model
      @category.save
    end
    
    # Valid product
    it 'is valid with valid attributes' do
      product = Product.new(name: 'Some name', price: 100, quantity: 10, category: @category)
      expect(product).to be_valid
    end
    
    it 'should not be valid without a name' do
      product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    
    it 'should not be valid without a price' do
      product = Product.new(name: 'Some name', price: nil, quantity: 10, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'should not be valid without a quantity' do
      product = Product.new(name: 'Some name', price: 100, quantity: nil, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'should not be valid without a category' do
      product = Product.new(name: 'Some name', price: 100, quantity: 10, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end