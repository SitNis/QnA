class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
