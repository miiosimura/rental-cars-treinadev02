class AddRentalStatusToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :rental_status, :integer, default: 0
  end
end
