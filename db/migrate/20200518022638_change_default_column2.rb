class ChangeDefaultColumn2 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :records, :page_amount, nil
  end
end
