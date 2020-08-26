class TopController < ApplicationController
  def index
    @recent_bookmarks = Bookmark.order(id: :desc).limit(10)
  end
end
