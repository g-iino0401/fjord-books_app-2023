class AddTitleAndCreatedAtToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :title, :string
  end
end
