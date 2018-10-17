class CreateInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :infos do |t|
      t.string :title_ru
      t.string :title_orig
      t.string :poster_link
      t.string :album_name
      t.string :song_name
      t.string :song_link

      t.timestamps
    end
  end
end
