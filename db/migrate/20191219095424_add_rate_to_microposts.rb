# frozen_string_literal: true

class AddRateToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :rate, :float
  end
end
