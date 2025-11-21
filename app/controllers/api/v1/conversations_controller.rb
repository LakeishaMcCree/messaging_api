module Api
    module V1
        class ConversationsController < ApplicationController

            #GET /api/v1/conversations
            def index
                conversations = current_user.conversations
                render json: conversations, status: :ok
            end

            #GET /api/conversations/:id
            def show
                conversation = current_user.conversations.find(params[:id])
                render json: conversation, include: [:messages], status: :ok
            end

            #POST /api/v1/conversations
            def create 
                conversation = Conversation.new(conversation_params)

                if conversation.save
                    #Add the creator as a participant
                    ConversationParticipant.create!(
                        user: current_user, 
                        conversation: conversation
                    )

                    render json: conversation, status: :created
                else
                    render json: { errors: conversation.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            def conversation_params
                params.require(:conversation).permit(:title, :conversation_type)
            end
        end
    end
end

