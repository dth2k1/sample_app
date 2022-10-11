class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]    #truy van theo thoi gian som nhat nen tao index created_at #dung ca 2 khoa trong aray
  end
end
