require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @stores = Store.all()
  @brands = Brand.all()
  erb(:index)
end

post('/add_store') do
  name = params[:store_name]
  new_store = Store.new({:name => name})
  if new_store.save()
    redirect('/')
  else
    @stores = Store.all()
    @brands = Brand.all()
    @errors_store = new_store.errors.full_messages
    erb(:index)
  end
end

post('/add_brand') do
  name = params[:name]
  price = params[:price]
  new_brand = Brand.create({:name => name, :price => price})
  if new_brand.save()
    redirect('/')
  else
    @stores = Store.all()
    @brands = Brand.all()
    @errors_brand = new_brand.errors.full_messages
    erb(:index)
  end
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
    if !@store.update(:name => name)
      @errors_store = @store.errors.full_messages
      @store = Store.find(id)
      @brands = Brand.all() - @store.brands()
      return erb(:store)
    end
  end

  if brand_ids != ""
    brand_ids.each() do |brand_id|
      brand = Brand.find(brand_id)
      @store.brands().push(brand)
    end
  end

  redirect('/stores/'.concat((@store.id).to_s))
end

delete('/stores/:id') do
  id = params.fetch('id').to_i
  @store = Store.find(id)
  @store.delete()
  redirect('/')
end

get('/brands/:id') do
  id = params.fetch('id').to_i
  @brand = Brand.find(id)
  @stores = Store.all()
  erb(:brand)
end

delete('/brands/:id') do
  id = params.fetch('id').to_i
  @brand = Brand.find(id)
  @brand.delete()
  redirect('/')
end

patch('/brands/:id') do
  id = params.fetch('id').to_i
  name = params.fetch('name')
  @brand = Brand.find(id)
  if name != ""
    if !@brand.update(:name => name)
      @errors_brand= @brand.errors.full_messages
      @brand = Brand.find(id)
      return erb(:brand)
    end
  end
  redirect('/brands/'.concat((@brand.id).to_s))
end
