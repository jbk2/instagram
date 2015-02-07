class Post < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 3, message: 'must have min 3 chars' }
  # validates :image, :attachment_presence => true
  belongs_to :user
  has_and_belongs_to_many :tags
  has_attached_file :image,
    :styles => { :thumb => '250x250>' },
    storage: :s3,
    s3_credentials: {
      bucket: 'instagram-clone-jbk',
      access_key_id: Rails.application.secrets.s3_access_key,
      secret_access_key: Rails.application.secrets.s3_secret_key
    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def tag_names
    ''
  end

  def tag_names=(tag_names)
    return if tag_names.blank?

    tag_names.split(/,\s?/).uniq.each do |tag_name|
      formatted_name = '#' + tag_name.delete('#')

      tag = Tag.find_or_create_by(name: formatted_name)
      tags << tag
    end
  end
end
