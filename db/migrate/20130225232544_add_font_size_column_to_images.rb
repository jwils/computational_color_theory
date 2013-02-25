class AddFontSizeColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :font_size, :integer
  end
end
