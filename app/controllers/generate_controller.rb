class GenerateController < ApplicationController
  def index
    if params[:seed]
      @generated = params[:seed] * 2 + ' dabl epl'
    end
  end
end
