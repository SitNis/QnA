class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :value
      t.belongs_to :user, foreign_key: true
      t.belongs_to :votable, polymorphic: true

      t.timestamps
    end
  end
end
