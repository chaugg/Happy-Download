class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get current_user.id, params[:user_id]
    add_to_conversations unless conversated?
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @conversation = Conversation.find_by id: params[:id]
    if @conversation.present?
      session[:conversations].delete @conversation.id
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_path, notice: t(".not_found")
    end
  end

  private
  def add_to_conversations
    session[:conversations] ||= Array.new
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include? @conversation.id
  end
end
