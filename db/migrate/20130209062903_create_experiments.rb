class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.references :turkee_tasks

      t.timestamps
    end
    add_index :experiments, :question_id
    add_index :experiments, :turkee_tasks_id
  end
end
