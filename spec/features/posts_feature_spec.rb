require 'rails_helper'
describe 'posts index page' do
  context 'no posts have been added yet' do
    it "should display 'No posts yet.' message" do
      visit '/posts'
      expect(page).to have_content 'No posts yet.'
    end
  end
end

context 'when logged in' do
  before do
    user = User.create(email: 'james@bibble.com',
      password: '12345678',
      password_confirmation: '12345678',
      id: '1')
    login_as user
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
  before { Post.create(name: 'test pic', description: 'test image', user_id: '1') }
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

  describe 'deleting my own post' do
    before { Post.create(name: 'test pic', description: 'test image', user_id: '1') }
    it 'deletes my post' do
      visit '/posts'
      click_link 'Delete test pic'

      expect(page).not_to have_content 'test pic'
      expect(page).to have_content 'Deleted successfully'
    end
  end
end

describe 'deleting another users post' do
  before do
    user1 = User.create(email: 'james@bibble.com',
      password: '12345678',
      password_confirmation: '12345678')
      Post.create(name: 'test pic1', description: 'test image1', user: user1)

    user2 = User.create(email: 'james2@bibble.com',
      password: '12345678',
      password_confirmation: '12345678')
      Post.create(name: 'test pic2', description: 'test image2', user: user2)
    login_as user1
  end
  
  it 'does not show delete links for another users post' do
    visit 'posts'

    expect(page).not_to have_content 'Delete test pic2'
  end
  # it 'does not allow deletion of another users post' do
  #   visit 'posts'
  #   click_link 'Delete test pic2'

  #   expect(page).to have_content 'test pic2'
  #   expect(page).to have_content 'Not your post!'
  # end
end

context 'when not logged in' do
  describe 'creating a post' do
    it 'prompts us to log in' do
      visit '/posts'
      click_link 'New post'

      expect(page).to have_content 'Log in'
    end
  end
end
