module Api
    module V1
        class MessagesController < ApplicationController
            before_action :set_conversation

            #GET /api/v1/conversations/:conversation_id/messages
            def index
                messages = @conversation.messages.recent_first
                render json: messages, status: :ok
            end

            #POST /api/v1/conversations/:conversation_id/messages
            def create
                message = @conversation.messages.new(message_params.merge(user: current_user))

                if message.save
                    render json: message, status: :created
                else
                    render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            def set_conversation
                @conversation = current_user.conversation.find(params[:conversation_id])
            end

            def message_params
                params.require(:message).permit(:body)
            end
        end
    end
end

