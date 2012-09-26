class CreateDomains < ActiveRecord::Migration
  def up
    create_table :domains do |t|
      t.references  :account
      t.string      :name
      t.text        :description
      t.string      :scheme
      t.string      :domain
      t.string      :port
      t.boolean     :checkPageRank
      t.boolean     :checkPageSpeed
      t.boolean     :checkYSlow
      t.boolean     :checkContentForChanges
      t.string      :mainContainer
      t.string      :navigationContainer
      t.string      :subnavigationContainer
      t.string      :ignoreContainer
      t.boolean     :checkPublishTime
      t.string      :regxPublishTime
      t.boolean     :active
      t.integer     :sortorder
      
      t.timestamps
    end

    add_index :domains, :account_id
    add_index :domains, :name
    add_index :domains, :domain
    add_index :domains, :sortorder

    add_foreign_key(:domains, :accounts)
  end

  def down
    drop_table :domains
  end
end
