class GenerateController < ApplicationController
  def index
    @generated = TextGenerator.new.generate(params[:seed]) if params.key?(:seed)
  end
end
