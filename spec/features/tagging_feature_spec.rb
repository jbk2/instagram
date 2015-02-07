require 'rails_helper'

describe 'tagging posts' do
  before do
    user = create(:user)
    login_as user
  end

  it 'displays the tags on the post page' do
        visit '/posts/new'
        fill_in 'Name', with: 'dog pic'
        fill_in 'Description', with: 'mucky Frank'
        attach_file 'Image', Rails.root.join('spec/images/dog1img.png')
        fill_in 'Tags', with: 'canine, animal'

        click_button 'Post it'

        expect(page).to have_link '#canine'
        expect(page).to have_link '#animal'
  end

  context 'it can filter posts by tag' do
    before do
      create(:post, name: 'Pic1', tag_names:'yolo')
      create(:post, name: 'Pic2', tag_names:'swag')
      visit '/posts'
    end

    it 'uses the tag name in the url' do
      click_link '#yolo'

      expect(current_path).to eq '/tags/yolo'
    end

    it 'only shows posts with the selected tag' do

      click_link '#yolo'

      expect(page).to have_css 'h2', text: 'Posts tagged with #yolo'
      expect(page).to have_content 'Pic1'
      expect(page).not_to have_content 'Pic2'
    end
  end
end