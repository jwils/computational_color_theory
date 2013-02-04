class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :ruler_height
      t.integer :ruler_width
      t.string :ip_address
      t.text :comments
      t.references :turkee_task

      t.timestamps
    end
    add_index :surveys, :turkee_task_id
  end

  create_table 'questions_surveys', :id => false do |t|
    t.column :survey_id, :integer
    t.column :question_id, :integer
  end
end
