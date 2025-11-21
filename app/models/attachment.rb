class Attachment < ApplicationRecord
  belongs_to :message

  validates :file_url, presence: true
end
