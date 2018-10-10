module MultiSession
  class Session
    def initialize cookies
      @cookies = cookies
    end

    def [](key)
      return nil unless @cookies[key.to_s].present?
      session = ActiveSupport::JSON.decode encryptor(key).decrypt_and_verify(@cookies[key])
      session['value'] # TODO: add ability to let developer retrieve the session_id
    end

    def []=(key, value)
      previous_session = self[key]
      session_id = if previous_session && previous_session['session_id'].present?
        previous_session['session_id']
      else
        SecureRandom.hex(16).encode Encoding::UTF_8
      end

      new_session = {
        'session_id' => session_id,
        'value' => value
      }
      expiry_options = MultiSession.expires.present? ? {expires_at: Time.now + MultiSession.expires} : {}
      encrypted_and_signed_value = encryptor(key).encrypt_and_sign ActiveSupport::JSON.encode(new_session), expiry_options

      raise ActionDispatch::Cookies::CookieOverflow if encrypted_and_signed_value.bytesize > ActionDispatch::Cookies::MAX_COOKIE_SIZE

      @cookies[key.to_s] = {value: encrypted_and_signed_value}.merge(MultiSession.expires.present? ? {expires: MultiSession.expires} : {})
      nil
    end

    def clear
      @cookies.clear
    end

    def update_expiration
      Rails.application.credentials[:multi_session_keys].each_key do |key|
        self[key] = self[key] # decrypt and re-encrypt to force expires_at to update
      end
    end

    private

    def encryptor key
      secret_key_base = Rails.application.credentials[:multi_session_keys][key.to_sym]
      raise ArgumentError.new("Rails.application.credentials[:multi_session_keys][:'#{key}'] has not been set.") unless secret_key_base.present?

      encrypted_cookie_cipher = 'aes-256-gcm'
      key_generator = ActiveSupport::CachingKeyGenerator.new ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
      key_len = ActiveSupport::MessageEncryptor.key_len encrypted_cookie_cipher
      salt = 'authenticated encrypted cookie'
      secret = key_generator.generate_key(MultiSession.authenticated_encrypted_cookie_salt, key_len)

      ActiveSupport::MessageEncryptor.new secret, cipher: encrypted_cookie_cipher, serializer: ActiveSupport::MessageEncryptor::NullSerializer
    end
  end
end
