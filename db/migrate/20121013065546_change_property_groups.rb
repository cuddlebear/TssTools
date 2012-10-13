class ChangePropertyGroups < ActiveRecord::Migration
  def up
    add_column :property_groups,  :property_group_id, :integer, :references=>"property_groups"
    add_index :property_groups, :property_group_id

    add_foreign_key(:property_groups, :property_groups)
  end

  def down
    remove_column :property_groups,  :property_group, :t.references
  end
end
