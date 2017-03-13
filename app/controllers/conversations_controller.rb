class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@conversations = current_user.mailbox.conversations
  end

  def inbox 
  	@conversations = current_user.mailbox.inbox
  end 

  def sent 
  	@conversations = current_user.mailbox.sentbox
  end 

  def trash
  	@conversations = current_user.mailbox.trash
  end 

  def show 
  	@conversation = current_user.mailbox.conversations.find(params[:id])
  	@conversation.mark_as_read(current_user)
  	@message = Mailboxer::Message.new
  end 

  def new 
  	@conversation = Mailboxer::Conversation.new 
  	@recipients = User.all - [current_user]
  end 

  def create 
  	recipients = User.where(username: params[:usernames])
  	receipt = current_user.send_message(
      recipients,
      params[:body],
      params[:subject],
      true, # sanitize_text
      params[:attachment]
    )
  	redirect_to conversation_path(receipt.conversation)
  end 
end
