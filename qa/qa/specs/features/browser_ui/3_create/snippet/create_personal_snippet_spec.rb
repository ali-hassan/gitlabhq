# frozen_string_literal: true

module QA
  RSpec.describe 'Create', :smoke do
    describe 'Personal snippet creation' do
      it 'User creates a personal snippet' do
        Flow::Login.sign_in

        Page::Main::Menu.perform do |menu|
          menu.go_to_more_dropdown_option(:snippets_link)
        end

        Resource::Snippet.fabricate_via_browser_ui! do |snippet|
          snippet.title = 'Snippet title'
          snippet.description = 'Snippet description'
          snippet.visibility = 'Private'
          snippet.file_name = 'New snippet file name'
          snippet.file_content = 'Snippet file text'
        end

        Page::Dashboard::Snippet::Show.perform do |snippet|
          expect(snippet).to have_snippet_title('Snippet title')
          expect(snippet).to have_snippet_description('Snippet description')
          expect(snippet).to have_visibility_type(/private/i)
          expect(snippet).to have_file_name('New snippet file name')
          expect(snippet).to have_file_content('Snippet file text')
        end
      end
    end
  end
end
