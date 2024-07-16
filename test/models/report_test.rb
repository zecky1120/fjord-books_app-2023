# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    alice = users(:alice)
    bob = users(:bob)
    alice_report = reports(:alice)
    assert alice_report.editable?(alice)
    assert_not alice_report.editable?(bob)
  end

  test 'created_on' do
    alice_report = reports(:alice)
    assert_equal alice_report.created_at.strftime('%Y/%m/%d'), I18n.l(alice_report.created_on)
  end

  test 'save_mentions' do
    alice_report = reports(:alice)
    bob = users(:bob)
    bob_report = bob.reports.create!(title: 'アリスの記事を言及している', content: "http://localhost:3000/reports/#{alice_report.id}")
    assert_includes(alice_report.mentioned_reports, bob_report)
    assert_not_includes(bob_report.mentioned_reports, alice_report)
    assert bob_report.mentioning_reports.find(alice_report.id)
    update_content = '言及日報のURLを削除'
    bob_report.update(title: '上書きしたよ', content: update_content)
    assert_not_includes(bob_report.mentioned_reports, alice_report)
  end
end
