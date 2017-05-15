require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @stores = Store.all()
  @brands = Brand.all()
  erb(:index)
end

post('/add_store') do
  name = params[:name]
  if name != ""
    new_store = Store.create({:name => name})
  end
  @stores = Store.all()
  @brands = Brand.all()
  erb(:index)
end

post('/add_brand') do
  name = params[:name]
  price = params[:price]
  if name != "" && price != ""
    new_brand = Brand.create({:name => name, :price => price})
  end
  @stores = Store.all()
  @brands = Brand.all()
  erb(:index)
end

get('/stores/:id') do
  id = params.fetch('id').to_i
  @store = Store.find(id)
  @brands = Brand.all() - @store.brands()
  erb(:store)
end

patch('/stores/:id') do
  id = params.fetch('id').to_i
  name = params.fetch('name')
  brand_ids = params.fetch("brand_ids", "")
  @store = Store.find(id)
  if name != ""
    @store.update(:name => name)
  end

  if brand_ids != ""
    brand_ids.each() do |brand_id|
      brand = Brand.find(brand_id)
      @store.brands().push(brand)
    end
  end
  @brands = Brand.all() - @store.brands()
  erb(:store)
end

delete('/stores/:id') do
  id = params.fetch('id').to_i
  @store = Store.find(id)
  @store.delete()
  @stores = Store.all()
  @brands = Brand.all()
  erb(:index)
end

get('/brands/:id') do
  id = params.fetch('id').to_i
  @brand = Brand.find(id)
  @stores = Store.all()
  erb(:brand)
end
