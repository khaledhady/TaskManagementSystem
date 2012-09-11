class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :version
      t.date :start_date
      t.date :end_date
      t.integer :project_id

      t.timestamps
    end
  end
end
