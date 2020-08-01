class AdminController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.x.admin_login,
                              password: Rails.configuration.x.admin_password,
                              realm: 'admin'
  def index
    @texts = SourceText.paginate(page: params[:page], per_page: 5)
  end

  def load_posts
    service = VkPosts.new

    parse_time = Time.now

    offset = 0
    new_count = 0

    loop do
      posts = service.wall_get(offset)['items']
      offset += posts.length

      models = posts.map do |p|
        {
          text: p['text'],
          post_id: p['id'].to_s,
          domain: Rails.configuration.x.posts_domain,
          parse_time: parse_time,
          created_at: Time.now,
          updated_at: Time.now
        }
      end

      ids = models.map { |p| p[:post_id] }

      present_ids = SourceText.where(post_id: ids).pluck(:post_id)

      new_posts = models.reject { |m| present_ids.include?(m[:post_id]) }

      break if new_posts.empty?

      SourceText.insert_all!(new_posts)

      new_count += new_posts.length
    end

    redirect_to admin_path, notice: "Added #{new_count} posts"
  end

  def delete_all_posts
    SourceText.delete_all

    redirect_to admin_path, notice: 'Deleted all posts'
  end
end
