require 'rails_helper'

describe Post do
  it 'is not valid without a name' do
    post = Post.new(name: nil)
    expect(post).to have(2).errors_on(:name)
  end

  it 'is not valid with less than 3 chars' do
    post = Post.new(name: 'ab')
    expect(post).to have(1).errors_on(:name)
  end
end