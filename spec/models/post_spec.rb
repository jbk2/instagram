require 'rails_helper'

describe Post do
  let(:post) { create(:post) }

  it 'is not valid without a name' do
    post = Post.new(name: nil)
    expect(post).to have(2).errors_on(:name)
  end

  it 'is not valid with less than 3 chars' do
    post = Post.new(name: 'ab')
    expect(post).to have(1).errors_on(:name)
  end

  describe '#tag_names=' do
    describe 'no tags' do
      it 'does nothing' do
        post.tag_names = ''

        expect(post.tags).to be_empty
      end
    end

    describe 'one tag' do
      it 'adds a single tag to the post' do
        post.tag_names = 'yolo'

        expect(post.tags.count).to eq 1
      end

      it 'prepends the tag with a # if neccessary' do
        post.tag_names = 'yolo'
        tag = post.tags.last

        expect(tag.name).to eq '#yolo'
      end

      it "does not double up #'s" do
        post.tag_names = '#yolo'
        tag = post.tags.last

        expect(tag.name).to eq '#yolo'
      end
    end

    describe 'multiple comma-separated tags' do
      it 'adds each tag to the post' do
        post.tag_names = 'yolo, swag'

        expect(post.tags.count).to eq 2
      end

      it "splits the tags even if there's no space" do
        post.tag_names = 'yolo, swag'

        expect(post.tags.count).to eq 2
      end

      it 'does not save spaces if there are any in a tag string' do
        post.tag_names = 'yolo, swag'
        last_tag = post.tags.last

        expect(last_tag.name).to eq '#swag'
      end
    end

    describe 'reusing tags' do
      let!(:tag) { Tag.create(name: '#yolo') }

      it 'reuses tags if they already exist' do
        post.tag_names = 'yolo'
        
        expect(Tag.count).to eq 1
        expect(tag.posts).to include post
      end
    end

    describe 'multiple duplicate tags' do
      it 'usues only unique tags' do
        post.tag_names = 'yolo, swag, yolo'

        expect(post.tags.count).to eq 2
      end
    end
  end
end