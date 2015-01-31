class Post < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 3, message: 'must have min 3 chars' }
  # validates :image, :attachment_presence => true
  has_attached_file :image,
    :styles => { :thumb => '200x200>' },
    storage: :s3,
    s3_credentials: {
      bucket: 'instagram-clone-jbk',
      access_key_id: Rails.application.secrets.s3_access_key,
      secret_access_key: Rails.application.secrets.s3_secret_key
    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
