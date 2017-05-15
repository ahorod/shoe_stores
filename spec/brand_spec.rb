require('spec_helper')

describe(Brand) do
  describe("#stores") do
    it('brand is featured in many stores') do
      brand = Brand.create({:name => "Ecco", :price => 90.00})
      store1 = brand.stores.create({:name => "His shoes"})
      store2 = brand.stores.create({:name => "Her shoes"})
      expect(brand.stores()).to(eq([store1, store2]))
    end
  end
end
