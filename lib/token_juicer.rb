require "token_juicer/version"
require 'jwt'

class TokenJuicer
  def initialize(secret_key, token_prefix, valid_ttl, redis)
    @valid_ttl = valid_ttl
    @token_prefix = token_prefix
    @secret_ket = secret_key
    @redis = redis
  end

  def encode_token(payload)
    token_expire_at = Time.now().to_i + @valid_ttl
    payload.merge!({ token_expire_at: token_expire_at })
    JWT.encode(payload, @secret_ket, 'HS256')
  end

  def decode_token(token)
    info = JWT.decode(token, @secret_ket, true, { algorithm: 'HS256' })
    info[0]
  end

  def cache_token(token)
    redis.set(token_key(token), true, ex: @valid_ttl)
  end

  def del_token(token)
    redis.del(token_key(token))
  end

  def token_valid?(token)
    regrex = /^[A-Za-z0-9\-_=]+\.[A-Za-z0-9\-_=]+\.?[A-Za-z0-9\-_.+\/=]*$/
    regrex.match?(token)
  end

  def token_exist?(token)
    redis.exists(token_key(token))
  end

  def token_key(token)
    @token_prefix + token.to_s
  end
end
