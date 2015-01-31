class Post < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 3, message: 'must have min 3 chars' }
  # validates :image, :attachment_presence => true
  has_attached_file :image, :styles => { :thumb => '200x200>' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
