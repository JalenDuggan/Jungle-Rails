require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:all) do
      @category = Category.new(name: "instruments")
      @category.save
      @product = Product.new(name: "1951 Precision Bass NOS", 
      description: "Features a two-piece select ash body and a one-piece tinted quartersawn maple neck with a '51 "U" profile, 7.25in fingerboard radius and 20 medium vintage frets for perfect feel and comfort just like the original.", 
      price_cents: 50000, quantity: 4, category_id: @category.id)
      @product.save
    end
    
    it 'Has a category' do
      expect(@product.category_id).to be_present
    end

    it 'Product has a name' do
      expect(@product.name).to be_present
    end

    it 'Has a quantity value' do
      expect(@product.quantity).to be_present
    end

    it 'Has a listing price' do
      expect(@product.price_cents).to be_present
    end

  end

  describe 'Error Validations' do

    before(:all) do
      @category = Category.new(name: "Watches")
      @category.save
    end

    it 'returns error if there is no name' do
      @product = Product.new(name: nil, description: "Museum dial was designed by artist Nathan George Horwitt in 1947", price_cents: 4000, quantity: 8, category_id: @category.id)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should return error if there is no price' do
      @product = Product.new(name: 'Movado Face', description: "Museum dial was designed by artist Nathan George Horwitt in 1947", price_cents: nil, quantity: 8, category_id: @category.id)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should return error if there is no quantity' do
      @product = Product.new(name: 'Movado Face', description: "Museum dial was designed by artist Nathan George Horwitt in 1947", price_cents: 4000, quantity: nil, category_id: @category.id)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should return error if there is no category' do
      @product = Product.new(name: 'Movado Face', description: "Museum dial was designed by artist Nathan George Horwitt in 1947", price_cents: 4000, quantity: 8, category_id: nil)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end