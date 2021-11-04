class CreateSolutions < ActiveRecord::Migration[6.1]
  def change
    create_table :solutions do |t|
      t.text :content, null: false
      t.references :article, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
