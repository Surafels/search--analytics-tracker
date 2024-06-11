class CreateSearchRecords < ActiveRecord::Migration[7.1]
    def change
      create_table :search_records do |t|
        t.string :query, null: false
        t.string :ip_address, null: false
  
        t.timestamps
      end
      add_index :search_records, [:query, :ip_address], unique: true
    end
  end