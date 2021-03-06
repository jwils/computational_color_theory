class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :survey
      t.references :question
      t.string :chosen_image
      t.integer :reversed
      t.timestamps
    end

    add_index :responses, :survey_id
    add_index :responses, :question_id
  end
end
