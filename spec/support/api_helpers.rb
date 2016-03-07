module ApiHelpers
  def api_get path, *args
    get "/api/v1/#{path}", *args
  end

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end
