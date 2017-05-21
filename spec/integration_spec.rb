require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stores *;")
    DB.exec("DELETE FROM brands *;")
    DB.exec("DELETE FROM brands_stores *;")
  end
end

describe('adding a new store', {:type => :feature}) do
  it('allows a user to add a new store') do
    visit('/')
    fill_in('store_name', :with =>'Roro')
    click_button('Add Store')
    expect(page).to have_content('Roro')
  end
end

describe('adding a new brand', {:type => :feature}) do
  it('allows a user to add a brand') do
    visit('/')
    fill_in('name', :with =>'Ecco')
    fill_in('price', :with => 90.00)
    click_button('Add Brand')
    expect(page).to have_content('Ecco')
  end
end

describe('assign brands to store', {:type => :feature}) do
  it('allows a user to see all brands for specific store') do
    store = Store.create({:name => "Murphy's shoes"})
    brand1 = Brand.create({:name => "Ecco", :price => 80.00})
    brand2 = Brand.create({:name => "Clarks", :price => 60.00})
    store.update({:brand_ids => [brand1.id(), brand2.id()]})
    visit('/')
    click_link("Murphy's shoes")
    expect(page).to have_content('Brands: Ecco Clarks')
  end
end

describe('delete store', {:type => :feature}) do
  it('allows a user to delete a store') do
    store = Store.create({:name => "Murphy's shoes"})
    store = Store.create({:name => "Mur shoes"})
    visit('/')
    click_link("Murphy's shoes")
    click_button('Delete')
    expect(page).to have_content('Mur shoes')
  end
end
