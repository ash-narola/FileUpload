module Api::V1
  class UsersController < ApplicationController

    def index
      render json: User.all
    end

    def create
      message = User.import_by_file_type(params[:file])
      if message.empty?
        render json: {status: 200}
      else
        render json: {status: 400, errors: message}
      end
    end

  end
end
