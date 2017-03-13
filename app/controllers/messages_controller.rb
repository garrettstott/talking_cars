class MessagesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_conversation

	def create 
		receipt = current_user.reply_to_conversation(
			@conversation,
			params[:body],
			nil, # subject
			true, # should_untrash
			true, # sanitize_text
			params[:attachment]
		)
		redirect_to conversation_path(receipt.conversation)
	end 

	private 

	def set_conversation 
		@conversation = current_user.mailbox.conversations.find(params[:id])
	end 
end
