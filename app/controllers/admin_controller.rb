class AdminController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.x.admin_login,
                              password: Rails.configuration.x.admin_password,
                              realm: 'admin'
  def index
  end
end
