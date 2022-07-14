class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :auth0_uid, index: { unique: true }
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end
