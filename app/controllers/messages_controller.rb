class MessagesController < ApplicationController
  before_action :authenticate_user!

  def all
    @messages = current_user.mailbox.conversations
    #alfa gets the last conversation (chronologically, the first in the inbox)
    conversation = current_user.mailbox.inbox.last

    #alfa gets it receipts chronologically ordered.
    @receipts = conversation.receipts_for(current_user)
  end
end
