class VkPosts
  def initialize
    @app_id = Rails.configuration.x.vk_app_id
    @secret = Rails.configuration.x.vk_secret
    @service = Rails.configuration.x.vk_service
  end

  def request(method, params)
    path = "https://api.vk.com/method/#{method}"

    configs = {
      access_token: @service,
      v: '5.122'
    }
    response = HTTParty.get(path, query: params.merge(configs))
    JSON.parse(response.body)['response']
  end

  def wall_get_many(domain)
    request('wall.get', domain: domain, count: 100)['items']
  end

  def texts(domain)
    wall_get_many(domain).map { |p| p['text'] }
  end
end
