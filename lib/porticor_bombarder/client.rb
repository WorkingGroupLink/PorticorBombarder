require 'hashie'
require 'faraday_middleware'
require 'securerandom'

PORTICOR_CONFIGURATION = YAML.load_file(File.join('config', 'porticor.yml'))[Rails.env]
PORTICOR_REQUIRED_OPTIONS = %w(api_key api_secret api_url)

module PorticorBombarder

  class Client
    attr_accessor *PORTICOR_REQUIRED_OPTIONS

    def initialize
      PORTICOR_REQUIRED_OPTIONS.each do |r_port_option|
        raise InvalidOptions.new("You must specify your Porticor #{r_port_option}.") unless PORTICOR_CONFIGURATION[r_port_option].present?
        public_send("#{r_port_option}=", PORTICOR_CONFIGURATION[r_port_option])
      end
    end

    def create_and_get_encryption_key(name, algorithm = 'RSA2048', export = true)
      encryption_key = begin
        create_encryption_key(name, algorithm, export)
      rescue DuplicateItemError
        get_encryption_key(name)
      rescue Exception => e
        puts e.message
        nil
      end
      encryption_key
    end

    def get_encryption_key(name)
      response = get("/api/protected_items/#{URI.escape(name)}", api_cred: temp_cred)
      if success?(response)
        response.body.item
      else
        nil
      end
    end

    def create_encryption_key(name, algorithm = 'RSA2048', export = true)
      response = post("/api/protected_items/#{URI.escape(name)}", algorithm: algorithm, exportable: export, api_cred: temp_cred)
      if success?(response)
        response.body.item
      else
        case response.body['error_code']
          when 'CreateDuplicate'
            raise DuplicateItemError.new response.body['error']
          else
            raise Error.new response.body['error_code']
        end
      end
    end

    def temp_cred
      time = Time.now.to_i
      nonce = generate_nonce
      sig = sign_cred_request(nonce, time)

      @@temp_cred = begin
        response = get('/api/creds/get_temporary_credential',
                       api_key_id: api_key,
                       time: time,
                       nonce: nonce,
                       api_signature: sig)
        if success?(response)
          response.body.credential
        else
          nil
        end
      end
    end

    private

    # return true for successful response code
    def success?(response)
      response.success? && response.body['error'].empty?
    end

    # return some random string
    def generate_nonce
      SecureRandom.hex(8)
    end

    # Computing the Signature for get_temporary_credential Currently it works for API V1
    # VERSION - 2 will be done sometime later.
    def sign_cred_request(nonce, time)
      str_to_sign = "get_temporary_credential?api_key_id=#{api_key}&nonce=#{nonce}&time=#{time}"
      digest = OpenSSL::Digest.new('sha256')
      sig = OpenSSL::HMAC.hexdigest(digest, api_secret, str_to_sign)
      return 'hmac-sha256:' + sig
    end

    # returns Porticor's client connection
    def connection
      Faraday.new(url: api_url) do |conn|
        conn.request :json
        conn.use Faraday::Response::Mashify
        conn.response :json, content_type: /\bjson$/
        conn.response :raise_error
        conn.adapter Faraday.default_adapter
      end
    end

    # Porticor's API GET request
    def get(path, options = {})
      connection.get(path, options)
    end

    # Porticor's API requires PUT request for creating an encryption_key
    def post(path, options = {})
      connection.put(path) do |request|
        request.params = options
      end
    end

  end
end