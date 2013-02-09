class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :img1
      t.references :img2
      t.references :experiment

      t.timestamps
    end
    add_index :questions, :img1_id
    add_index :questions, :img2_id
  end
end
