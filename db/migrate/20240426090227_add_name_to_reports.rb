class AddNameToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :user_name, :string
  end
end
