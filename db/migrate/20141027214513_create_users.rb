class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name , :null => false
      t.text :email , :null => false
      t.text :password , :null => false
      t.timestamps
    end
  end
end
