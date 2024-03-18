# frozen_string_literal: true

class CreateSolutions < ActiveRecord::Migration[6.1]
  def change
    create_table :solutions do |t|
      t.text :content, null: false
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end
end
