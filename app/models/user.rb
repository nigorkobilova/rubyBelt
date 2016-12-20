class User < ActiveRecord::Base
  has_secure_password
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_many :songs
  has_many :playlists, dependent: :destroy
  has_many :songs_added, through: :playlists, source: :songs
  validates :first_name, :last_name, :email, :presence => true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: email_regex }
end
