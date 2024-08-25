# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:alice)
    @user = users(:alice)
    visit root_url
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test '日報の一覧表示される' do
    visit reports_url
    assert_text '日報の一覧'
  end

  test '日報の新規作成できる' do
    visit reports_url
    click_on '日報の新規作成'
    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_text @report.title
    assert_text @report.content
    assert_text 'アリス'
    assert_text I18n.l(@report.created_on)
    click_on '日報の一覧に戻る'
  end

  test '日報の編集ができる' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first
    fill_in 'タイトル', with: '日報タイトルの変更'
    fill_in '内容', with: '日報内容の変更'
    click_on '更新する'
    assert_text '日報が更新されました。'
    assert_text '日報タイトルの変更'
    assert_text '日報内容の変更'
    assert_text 'アリス'
    assert_text I18n.l(@report.created_on)
    click_on '日報の一覧に戻る'
  end

  test '日報の削除ができる' do
    visit reports_url
    assert_text '初めての日報'
    visit report_url(@report)
    click_on 'この日報を削除', match: :first
    assert_current_path reports_url
    assert_text '日報が削除されました。'
    assert_no_text '初めての日報'
  end
end
