class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :title
      t.text :content
      t.string :slug

      t.timestamps
    end
  end
end
