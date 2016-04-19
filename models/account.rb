require 'sequel'
require 'rbnacl/libsodium'
require 'base64'
require 'json'

# Holds a Project's information
class Account < Sequel::Model
  include EncryptableModel

  set_allowed_columns :username, :email
  one_to_many :owned_projects, class: :Project, key: :owner_id

  plugin :association_dependencies, :owned_projects => :delete

  def password=(new_password)
    nacl = RbNaCl::Random.random_bytes(RbNaCl::PasswordHash::SCrypt::SALTBYTES)
    digest = self.class.hash_password(nacl, new_password)
    self.salt = Base64.urlsafe_encode64(nacl)
    self.password_hash = Base64.urlsafe_encode64(digest)
  end

  def to_json(options = {})
    JSON({  type: 'account',
            username: username
          },
         options)
  end

  def self.hash_password(salt, pwd)
    opslimit = 2**20
    memlimit = 2**24
    digest_size = 64
    RbNaCl::PasswordHash.scrypt(pwd, salt, opslimit, memlimit, digest_size)
  end
end
