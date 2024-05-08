class RemoveUserIdFromReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :reports, :user_id, :integer
  end
end
