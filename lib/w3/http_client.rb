require 'net/http'

module W3
  class Http_Client
    attr_accessor :uri, :host, :port

    def initialize(host, username: nil, password: nil)
      @uri = URI.parse(host)
      raise ArgumentError unless ['http', 'https'].include? uri.scheme
      @host = uri.host
      @port = uri.port
      @username = username
      @password = password
    end

    def send(payload)
      http = ::Net::HTTP.new(@host, @port)
      header = {'Content-Type' => 'application/json'}
      request = ::Net::HTTP::Post.new(uri, header)
      request.basic_auth(@username, @password) if @username && @password
      request.body = payload
      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end
