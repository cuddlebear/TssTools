class CreateUrls < ActiveRecord::Migration
  def up
    create_table :urls do |t|
      t.string :path
      t.references :domain
      t.timestamps
    end

    add_index :urls, :path
    add_index :urls, :domain_id

    add_foreign_key(:urls, :domains)
  end

  def down
    drop_table :urls
  end

end
