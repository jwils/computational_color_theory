class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :experiment
      t.references :image
      t.float :psi
      t.float :noise

      t.timestamps
    end
    add_index :results, :experiment_id
    add_index :results, :image_id
  end
end
