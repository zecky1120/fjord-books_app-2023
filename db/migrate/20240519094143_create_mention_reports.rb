class CreateMentionReports < ActiveRecord::Migration[7.0]
  def change
    create_table :mention_reports do |t|
      t.integer :mentioning_report_id
      t.integer :mentioned_report_id

      t.timestamps
    end
    add_index :mention_reports, :mentioning_report_id
    add_index :mention_reports, :mentioned_report_id
  end
end
