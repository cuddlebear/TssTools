class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.references  :domain
      t.string      :path
      t.string      :title
      t.boolean     :active
      t.integer     :status
      t.integer     :pageRank
      t.integer     :pageSpeed
      t.integer     :ySlow
      t.integer     :checkCounter
      t.datetime    :lastChange
      t.datetime    :lastCheck
      t.string      :actContent
      t.timestamps
    end

    add_index :pages, :path
    add_index :pages, :domain_id
    add_index :pages, :status
    add_index :pages, :lastChange
    add_index :pages, :lastCheck

    add_foreign_key(:pages, :domains)
  end

  def down
    drop_table :pages
  end

end
