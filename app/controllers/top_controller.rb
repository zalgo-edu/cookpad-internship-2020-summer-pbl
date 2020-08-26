class TopController < ApplicationController
  def index
    @bookmarks = Bookmark.order(score: :desc)
  end
end
