require 'rails_helper'

RSpec.describe '検索機能', type: :system, js: true do
  include LoginSupport
  let(:user) { create(:user) }
  let(:category_html) { create(:category, name: 'html&css') }
  let(:category_javascript) { create(:category, name: 'javascript') }
  let(:category_ruby) { create(:category, name: 'ruby') }
  let!(:book_first) { create(:book, level: 'easy', volume: 'few', category: category_html, user: user )}
  let!(:book_second) { create(:book, level: 'normal', volume: 'medium', category: category_javascript, user: user) }
  let!(:book_third) { create(:book, level: 'hard', volume: 'many', category: category_ruby, user: user) }

  describe 'キーワード検索' do
    before do
      sign_in_as user
      visit books_path
    end

    context 'キーワード検索' do
      it '入力したタイトルの書籍のみが表示される' do
        fill_in 'search_spec', with: book_first.title
        click_button '検索'
        expect(page).to have_content(book_first.title)
        expect(page).to have_no_content(book_second.title)
        expect(page).to have_no_content(book_third.title)
      end
      it '選択したカテゴリの書籍のみが表示される' do
        all('form input')[2].click
        find('li', text: 'ruby').click
        click_on '検索'

        expect(page).to have_content(book_third.title)
        expect(page).to have_no_content(book_second.title)
      end
      it '選択したボリュームの書籍のみが表示される' do
        all('form input')[3].click
        find('li', text: 'おおい').click
        click_on '検索'

        expect(page).to have_content(book_third.title)
        expect(page).to have_no_content(book_second.title)
      end
      it '選択した難易度の書籍のみが表示される' do
        all('form input')[4].click
        find('li', text: 'やさしい').click
        click_on '検索'
        expect(page).to have_content(book_first.title)
        expect(page).to have_no_content(book_second.title)
      end
    end
  end

  describe 'タグ検索' do
    before do
      sign_in_as(user)
      visit new_book_path
      fill_in "book[title]", with: 'タグテスト'
      fill_in 'book[content]', with: 'テストしました'
      all('.input-text input')[1].click
      find('li', text: 'html&css').click
      all('.input-text input')[2].click
      find('li', text: 'むずかしい').click
      all('.input-text input')[3].click
      find('li', text: 'おおい').click
      fill_in "book[tag_list]", with: '#テストタグ'
      click_on '登録'
    end

    it '選択したタグに紐付く書籍のみが表示される' do
      visit books_path
      click_on 'タグ検索'
      click_on '#テストタグ'
      expect(page).to have_content 'タグテスト'
      expect(page).to have_link '詳細'
    end
  end

  describe '言語別検索' do
    before do
      visit books_path
    end

    it 'HTMLの書籍のみがが表示される' do
      click_on 'HTML&CSS'
      expect(page).to have_content(book_first.title)
      expect(page).to have_link '詳細', href: book_path(book_first)
    end

    it 'Javascriptの書籍のみが表示される' do
      click_on 'Javascript'
      expect(page).to have_content(book_third.title)
      expect(page).to have_link '詳細', href: book_third(book_third)
    end

    it 'Rubyの書籍が表示のみがされる' do
      click_on 'Ruby'
      expect(page).to have_content(book_second.title)
      expect(page).to have_link '詳細', href: book_path(book_second)
    end
  end
end
