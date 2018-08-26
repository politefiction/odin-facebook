class ChangeImageColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :image, :fbavatar
  end
end
