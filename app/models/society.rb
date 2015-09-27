class Society < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :users
  has_many :expenses
  validates :name, presence: true, uniqueness: true
  attr_accessor :invitees

  def invite(emails, sender)
    user_emails = emails.split(",")
    user_emails.each do |email|
      User.invite!( { email: email, society_id: self.id }, sender)
    end
  end
end
