class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :daily_rate
      t.decimal :car_insurance
      t.decimal :third_party_insurance

      t.timestamps
    end
  end
end
