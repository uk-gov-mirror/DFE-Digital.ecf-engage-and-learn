# frozen_string_literal: true

class RemoveClutterFromUser < ActiveRecord::Migration[6.1]
  def up
    change_table :users, bulk: true do |t|
      t.remove :login_token
      t.remove :login_token_valid_until
      t.remove :remember_created_at

      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.string :login_token
      t.datetime :login_token_valid_until
      t.datetime :remember_created_at

      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end
  end
end
