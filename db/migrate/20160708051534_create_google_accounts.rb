class CreateGoogleAccounts < ActiveRecord::Migration
  def change
    create_table :google_accounts do |t|
      t.integer :user_id
      t.string :email
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_in

      t.timestamps null: false
    end
    add_index :google_accounts, :user_id
  end
end
