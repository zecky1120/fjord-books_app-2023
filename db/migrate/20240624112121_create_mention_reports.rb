class CreateMentionReports < ActiveRecord::Migration[7.0]
  def change
    create_table :mention_reports do |t|
      t.integer :mentioning_report_id, null: false
      t.integer :mentioned_report_id, null: false

      t.timestamps
    end
    add_index :mention_reports, [:mentioning_report_id, :mentioned_report_id], unique: true, name: 'mention_reports_index'
  end
end
