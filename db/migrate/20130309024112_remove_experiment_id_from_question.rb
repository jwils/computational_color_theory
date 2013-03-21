class RemoveExperimentIdFromQuestion < ActiveRecord::Migration
  def up
    remove_column :questions, :experiment_id
  end

  def down
    add_column :questions, :experiment_id, :references
  end
end
