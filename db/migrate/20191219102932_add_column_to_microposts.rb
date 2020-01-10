# frozen_string_literal: true

class AddColumnToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_reference :microposts, :book, foreign_key: true
  end
end
