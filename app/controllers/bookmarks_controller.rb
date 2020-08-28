class BookmarksController < ApplicationController
  # GET /bookmarks
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

  # GET /bookmarks/1
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  # GET /bookmarks/new
  def new
    @bookmark_form = BookmarkForm.new
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
    @bookmark_form = BookmarkForm.new(@bookmark)
  end

  # POST /bookmarks
  def create
    @bookmark_form = BookmarkForm.new
    @bookmark_form.apply(bookmark_form_params)

    if @bookmark_form.valid?
      bookmark = Bookmark.new(@bookmark_form.to_attributes)
      Bookmark.transaction do
        if @bookmark_form.image_uploaded?
          image = Image.create!(@bookmark_form.to_image_attributes)
          bookmark.image_id = image.id
        end
        bookmark.save!
      end
      redirect_to bookmark, notice: 'Bookmark was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bookmarks/1
  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark_form = BookmarkForm.new(@bookmark)
    @bookmark_form.apply(bookmark_form_params)

    if @bookmark_form.valid?
      Bookmark.transaction do
        bookmark_attrs = @bookmark_form.to_attributes
        if @bookmark_form.image_uploaded?
          image = Image.create!(@bookmark_form.to_image_attributes)
          bookmark_attrs.merge(image_id: image.id)
        end
        @bookmark.update!(bookmark_attrs)
      end
      redirect_to @bookmark, notice: 'Bookmark was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookmarks/1
  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def bookmark_form_params
    params.require(:bookmark).permit(:title, :memo, :image, :score)
  end
end
