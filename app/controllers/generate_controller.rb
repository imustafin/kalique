class GenerateController < ApplicationController
  def index
    @generated = TextGenerator.new.generate(params[:seed])
  end
end
