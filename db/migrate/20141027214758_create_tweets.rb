class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :message , :limit => 140, :null => false
      t.belongs_to :users
      t.timestamps
    end
  end
end
