class Song < ActiveRecord::Base
  belongs_to :user
  has_many :playlists, dependent: :destroy
  has_many :users_added, through: :playlists, source: :user
  validates :artist, :title, presence: true, :length => {minimum: 2}
end
