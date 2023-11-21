class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 3 }
  validates :cpf, presence: true, uniqueness: {message: " já cadastrado!"}
  validates :password, length: { minimum: 4 }, allow_nil: true
  validate :cpf_verify
  has_many :visits, class_name: "Ahoy::Visit"

  def cpf_verify
    if cpf.gsub(/\D/, "").length != 11 
      errors.add(:cpf, ' precisa ter 11 números')
    end
  end
end
