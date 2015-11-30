module Api
  class ApplicationController < ActionController::Metal
    include ActionController::Rendering
    respond_to :json
  end
end
