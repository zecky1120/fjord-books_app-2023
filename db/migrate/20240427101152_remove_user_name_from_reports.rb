class RemoveUserNameFromReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :reports, :user_name, :string
  end
end
