class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :color_type
      t.integer :val1
      t.integer :val2
      t.integer :val3

      t.timestamps
    end
  end
end