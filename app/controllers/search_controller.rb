class SearchController < ApplicationController

  def term
    term = params[:term].downcase
    redirect_to searched_path(term)
  end

  def searched 
    @term = params[:term]
    @makes = Make.search(@term)
    @models = Model.search(@term)
    
  end

  def posts 
    @term = params[:term]
    @posts = Post.search(@term).paginate(page: params[:posts_page] || 1, per_page: 10)
    render partial: 'posts', locals: {posts: @posts}
  end 

  def replies 
    @term = params[:term]
    @replies = Reply.search(@term).paginate(page: params[:replies_page] || 1, per_page: 10)
    render partial: 'replies', locals: {replies: @replies}
  end 
end
