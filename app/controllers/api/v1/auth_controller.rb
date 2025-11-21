module Api 
    module V1
        class AuthController < ApplicationController
            skip_before_action : authenticate_request, only: %i[register login]

            #POST /api/v1/register
            def register
                user = User.new(user_params)
                
                if user.save 
                    token = JsonWebToken.encode(user_id: user.id)
                    render json: { token:, user: user_payload(user) }, status: :created 
                else
                    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            #POST /apiv1/login
            def login
                user = User.find_by(email: params[:email])

                if user&.authenticate(params[:password])
                    token = JsonWebToken.encode(user_id: user.id)
                    render json: { token:, user: user_payload(user) }, status: :ok 
                else
                    render json: { error: 'Invalid email or password' }, status: :unauthorized
                end
            end

            private
            
            def user_params
                params.require(:user).permit(:email, :name, :role, :password, :password_confirmation)
            end
            
            def user_payload(user)
                user.as_json(only: %i[id email name role])
            end
        end
    end
end



