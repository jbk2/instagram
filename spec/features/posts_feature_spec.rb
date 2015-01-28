require 'rails_helper' # or shoudl this be 'spec_helper'

describe 'posts index page' do
  context 'no posts have been added yet' do
    it "should display 'No posts yet.' message" do
      visit '/posts'
      expect(page).to have_content 'No posts yet.'
    end
  end
end

describe 'creating a post' do
  it 'adds it to the posts index page' do
    visit '/posts/new'
    fill_in 'Name', with: 'dog pic'
    fill_in 'Description', with: 'a dog jumping'
    click_button 'Create Post'

    expect(current_path).to eq '/posts'
    expect(page).to have_content 'dog pic'
  end

  describe 'editing a post' do
    before { Post.create(name: 'test pic', description: 'test image') }

    it 'saves the change to the post' do
      visit '/posts'
      click_link 'Edit test pic'
      fill_in 'Name', with: 'test pic1'
      click_button 'Update Post'

      expect(current_path).to eq '/posts'
      expect(page).to have_content 'test pic1'
    end
  end

  describe 'deleting a post' do
    before { Post.create(name: 'test pic', description: 'test image') }

    it 'deletes a post' do
      visit '/posts'
      click_link 'Delete test pic'

      expect(page).not_to have_content 'test pic'
    end
  end

end