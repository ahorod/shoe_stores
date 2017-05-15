class CreateBrandsStores < ActiveRecord::Migration[5.1]
  def change
    create_table(:stores) do |t|
      t.column(:name, :string)
      t.timestamps()
      t.index :name, unique: true
    end
    create_table(:brands) do |t|
      t.column(:name, :string)
      t.column(:price, :numeric)
      t.timestamps()
      t.index :name, unique: true
    end
  end
end
