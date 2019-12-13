class AddSubsidiaryRefToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :subsidiary, :reference
  end
end
