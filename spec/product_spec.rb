require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'should work' do
    expect('it').to be_truthy
  end

  describe 'Validations' do
    # validation tests/examples here
    it 'should be invalid with no value for caffeine' do
      product = Product.new
      expect(product.valid?).to(be(false))
      expect(product.valid?).to(be_falsey)
      expect(product).not_to(be_valid)
      expect(product).to_not(be_valid)
      expect(product.errors[:price]).to(include("can't be blank"))
    end
  end
end