module ApiHelpers
  def api_get path, *args
    get "/api/v1/#{path}", *args
  end

  def api_post path, *args
    post "/api/v1/#{path}", *args
  end

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end