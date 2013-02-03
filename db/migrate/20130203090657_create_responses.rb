class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :quiz
      t.references :question
      t.string :chosen_image

      t.timestamps
    end

    add_index :responses, :quiz_id
    add_index :responses, :question_id
  end
end
