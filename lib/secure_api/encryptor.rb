module SecureApi
  class Encryptor
    def initialize
      @secret = SecureApi.encryption_secret
      @len = ActiveSupport::MessageEncryptor.key_len
    end

    def encrypt(password)
      salt = SecureRandom.hex(@len)
      key = ActiveSupport::KeyGenerator.new(@secret).generate_key(salt, @len)
      crypt = ActiveSupport::MessageEncryptor.new(key)
      encrypted_data = crypt.encrypt_and_sign(password)
      "#{salt}$$#{encrypted_data}"
    end

    def decrypt(password)
      salt, encrypted_password = password.split "$$"
      key = ActiveSupport::KeyGenerator.new(@secret).generate_key(salt, @len)
      crypt = ActiveSupport::MessageEncryptor.new(key)
      crypt.decrypt_and_verify(encrypted_password)
    end

    def compare(password, psw)
      password == decrypt(psw)
    end
  end
end
