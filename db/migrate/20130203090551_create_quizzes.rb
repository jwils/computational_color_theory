class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :ruler_height
      t.integer :ruler_width
      t.string :ip_address
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :validation_hash
      t.string :worker_id

      t.timestamps
    end
  end
end
