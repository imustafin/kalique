class VkPosts
  def initialize
    @app_id = Rails.configuration.vk_app_id
    @secret = Rails.configuration.vk_secret
    @service = Rails.configuration.vk_service
  end

  def posts(domain)


  end
end
