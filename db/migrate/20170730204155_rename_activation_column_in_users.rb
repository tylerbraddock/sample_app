class RenameActivationColumnInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :acttivation_digest, :activation_digest 
  end
end
