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
    add_index :questions, :experiment_id
    create_table 'experiments_questions', :id => false do |t|
      t.column :experiment_id, :integer
      t.column :question_id, :integer
    end

  end
end
