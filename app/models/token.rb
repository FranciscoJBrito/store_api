class Token < ApplicationRecord
  belongs_to :user
  validates :token, :expires_at, presence: true
  after_initialize :generate_access_token

  private

  def generate_access_token
    loop do
      self.token = SecureRandom.hex
      break unless Token.where(token: token).any?
    end
    self.expires_at ||= 2.hours.from_now
  end
end
