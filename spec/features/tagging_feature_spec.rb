require 'rails_helper'

describe 'tagging posts' do
  before do
    user = create(:user)
    login_as user
  end

  it 'displays the tags on the post page' do
        fill_in 'Name', with: 'dog pic'
        fill_in 'Description', with: 'mucky Frank'
        attach_file 'Image', Rails.root.join('spec/images/dog1img.png')
        fill_in 'Tags', with: 'canine, animal'

        click_button 'Post it'

        expect(page).to have_link '#canine'
        expect(page).to have_link '#animal'
  end
end