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
end