module Api
  module V1
    class ApplicationController < ActionController::Metal
      include ActionController::Rendering
      respond_to :json
    end
  end
end
