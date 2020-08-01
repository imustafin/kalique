class GenerateController < ApplicationController
  def index
    return unless params.key?(:seed)
    @generated = TextGenerator.new.generate(params[:seed])
    @generated = :error if @generated.nil?
  end
end
