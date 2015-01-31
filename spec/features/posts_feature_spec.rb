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
  context 'with valid data' do
    it 'adds it to the posts index page' do
      visit '/posts/new'
      fill_in 'Name', with: 'dog pic'
      fill_in 'Description', with: 'a dog jumping'
      click_button 'Post it'

      expect(current_path).to eq '/posts'
      expect(page).to have_content 'dog pic'
      expect(page).not_to have_css 'img.uploaded-pic'

    end

    it 'can add a photo to our posts' do
      visit '/posts/new'
      fill_in 'Name', with: 'dog pic'
      fill_in 'Description', with: 'mucky Frank'
      attach_file 'Image', Rails.root.join('spec/images/dog1img.png')

      click_button 'Post it'

      expect(current_path).to eq posts_path
      expect(page).to have_css 'img.uploaded-pic'
    end
  end

  context 'with invalid data' do
    it 'displays error message if Name field is blank' do
      visit '/posts/new'
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'dog pic'
      click_button 'Post it'

      expect(page).to have_content 'errors'
    end
  end
end

describe 'editing a post' do
before { Post.create(name: 'test pic', description: 'test image') }
  context 'with valid data' do
    it 'saves the change to the post' do
      visit '/posts'
      click_link 'Edit test pic'
      fill_in 'Name', with: 'test pic1'
      click_button 'Post it'

      expect(current_path).to eq '/posts'
      expect(page).to have_content 'test pic1'
    end
  end

  context ' with invalid date' do
    it 'does not save the change to the post' do
      visit '/posts'
      click_link 'Edit test pic'
      fill_in 'Name', with: 'ab'
      click_button 'Post it'

      expect(current_path).not_to eq '/posts'
      expect(page).to have_content 'error'
    end
  end
end

describe 'deleting a post' do
  before { Post.create(name: 'test pic', description: 'test image') }

  it 'deletes a post' do
    visit '/posts'
    click_link 'Delete test pic'

    expect(page).not_to have_content 'test pic'
    expect(page).to have_content 'Deleted successfully'
  end
end

