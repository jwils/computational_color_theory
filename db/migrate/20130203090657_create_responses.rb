class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :Quiz
      t.references :Question
      t.string :chosen_image

      t.timestamps
    end
    add_index :responses, :Quiz_id
    add_index :responses, :Question_id
  end
end
