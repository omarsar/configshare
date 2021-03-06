require 'base64'
require 'rbnacl/libsodium'

# Makes a model EncryptableModel
# - Required: model must have nonce attribute
module EncryptableModel
  def key
    @key ||= Base64.strict_decode64(ENV['DB_KEY'])
  end

  def encrypt(plaintext)
    if plaintext
      secret_box = RbNaCl::SecretBox.new(key)
      new_nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
      ciphertext = secret_box.encrypt(new_nonce, plaintext)
      self.nonce = Base64.strict_encode64(new_nonce)
      Base64.strict_encode64(ciphertext)
    end
  end

  def decrypt(encrypted)
    if document_encrypted
      secret_box = RbNaCl::SecretBox.new(key)
      old_nonce = Base64.strict_decode64(nonce)
      ciphertext = Base64.strict_decode64(encrypted)
      secret_box.decrypt(old_nonce, ciphertext)
    end
  end
end
