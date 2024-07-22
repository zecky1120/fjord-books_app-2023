# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @user = users(:alice)
    visit root_url
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test '本の一覧表示される' do
    visit books_url
    assert_text '本の一覧'
  end

  test '本の新規作成ができる' do
    visit books_url
    click_on '本の新規作成'
    fill_in 'メモ', with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '登録する'
    assert_text '本が作成されました。'
    click_on '本の一覧に戻る'
  end

  test '本の編集ができる' do
    visit book_url(@book)
    click_on 'この本を編集', match: :first
    fill_in 'メモ', with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '更新する'
    assert_text '本が更新されました。'
    click_on '本の一覧に戻る'
  end

  test '本を削除できる' do
    visit book_url(@book)
    click_on 'この本を削除', match: :first
    assert_text '本が削除されました。'
  end
end
