class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_name
      t.references :fg_color
      t.references :bg_color
      t.timestamps
    end
  end
end
