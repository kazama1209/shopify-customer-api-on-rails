require "openssl"
require "time"
require "json"
require "base64"

class ShopifyMultipass
  attr_accessor :encryptionKey, :signingKey

  # Multipassログイン用の暗号化キーと署名キーを生成する
  def initialize(multipass_secret = nil)
    return if multipass_secret.blank?

    block_size = 16

    hash = OpenSSL::Digest.new("sha256").digest(multipass_secret)
    self.encryptionKey = hash[0, block_size]
    self.signingKey = hash[block_size, 32]
  end

  # 顧客情報を暗号化してトークンを生成する
  def generate_token(customer_data_hash)
    return if !customer_data_hash

    customer_data_hash["created_at"] = Time.now.iso8601
    cipherText = self.encrypt(customer_data_hash.to_json)

    Base64.urlsafe_encode64(cipherText + self.sign(cipherText))
  end

  def encrypt(plaintext)
    cipher = OpenSSL::Cipher.new("aes-128-cbc")
    cipher.encrypt
    cipher.key = self.encryptionKey

    cipher.iv = iv = cipher.random_iv

    iv + cipher.update(plaintext) + cipher.final
  end

  def sign(data)
    OpenSSL::HMAC.digest("sha256", self.signingKey, data)
  end

  # Shopify側で認証を行うための顧客情報とトークンが入ったURLを生成する
  def generate_url(customer_data_hash, domain)
    return if !domain
    return "https://" + domain + "/account/login/multipass/" + self.generate_token(customer_data_hash)
  end
end
