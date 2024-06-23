class AddMentioningReportIdToMentionReports < ActiveRecord::Migration[7.0]
  def change
    change_column_null :mention_reports, :mentioning_report_id, false, 0
    change_column_null :mention_reports, :mentioned_report_id, false, 0
  end
end
