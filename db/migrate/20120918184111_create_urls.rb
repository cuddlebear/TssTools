class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :path
      t.references :domain

      t.timestamps
    end
  end
end
