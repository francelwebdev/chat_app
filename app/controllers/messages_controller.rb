class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages/new
  def new
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.conversation_id = @conversation.id

    if @message.save!
      puts "Message ID:"
      puts @message.id
      respond_to do |format|
        format.js
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:conversation, :content, :conversation_id, :user_id)
    end
end
