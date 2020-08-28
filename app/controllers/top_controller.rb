class TopController < ApplicationController
  def index
    if params[:option] == "score_desc" || params[:option] == nil
      @bookmarks = Bookmark.order(score: :desc)
    elsif params[:option] == "score_asc"
      @bookmarks = Bookmark.order(score: :asc)
    elsif params[:option] == "created_at_desc"
      @bookmarks = Bookmark.order(created_at: :desc)
    elsif params[:option] == "created_at_asc"
      @bookmarks = Bookmark.order(created_at: :asc)
    end
  end
end
