class AddAncestryToProject < ActiveRecord::Migration
  def change
    add_column :projects, :ancestry, :string
  end
end
