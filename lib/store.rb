class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands

  validates :name, :presence => true
  validates :name, length: { maximum: 100 }
  validates :name, uniqueness: { case_sensitive: false, message: "this store already exists" }

  before_save :capitalize_name

  private
  def capitalize_name
    self.name = name().capitalize
  end


end
