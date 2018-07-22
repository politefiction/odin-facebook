class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type
      t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
