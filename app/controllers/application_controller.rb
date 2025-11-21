class ApplicationController < ActionController::API
    before_action :authenticate_request

    attr_reader :current_user

    private

    def authenticate_request
        header = request.headers['Authorization']
        token = header.split.last if header.present?

        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id]) if decoded

    rescue ActiveRecord::RecordNotFound, NoMethodError
        render json: { error: 'Not Authorized' }, status: :unauthorized
    end

    def authorize_role!(*roles)
        unless roles.map(&:to_s).include?(current_user&.role)
            render json: { error: 'Forbidden' }, status: :Forbidden
        end
    end
end
