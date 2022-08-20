class RenameDayIdColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :day_id, :shipping_date_id
  end
end
