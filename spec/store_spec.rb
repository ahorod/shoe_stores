require('spec_helper')

describe(Store) do
  describe("#brands") do
    it('store has many brands') do
      store = Store.create({:name => "Murphy's shoes"})
      brand1 = store.brands.create({:name => "Ecco", :price => 80.00})
      brand2 = store.brands.create({:name => "Clarks", :price => 60.00})
      expect(store.brands()).to(eq([brand1, brand2]))
    end
  end
end
