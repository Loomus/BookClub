class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :pages
      t.integer :year
      t.string :cover_image, default: "https://ibf.org/site_assets/img/placeholder-book-cover-default.png"

      t.timestamps
    end
  end
end
