class AddIndexUniqueToMentionReports < ActiveRecord::Migration[7.0]
  def change
    add_index :mention_reports, [:mentioning_report_id, :mentioned_report_id], unique: true, name: 'mention_reports_index'
  end
end
