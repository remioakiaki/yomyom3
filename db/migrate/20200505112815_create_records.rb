class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.date :yyyymmdd
      t.time :hhmm
      t.references :user, foreign_key: true
      t.references :bookshelf,foreign_key: true

      t.timestamps
    end
  end
end
