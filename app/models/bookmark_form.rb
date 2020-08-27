class BookmarkForm
  include ActiveModel::Validations

  attr_accessor :title, :memo, :score, :image

  validates :title, presence: true, length: { maximum: 255 }
  validate :validate_image

  def initialize(model = nil)
    if model
      @title = model.title
      @memo = model.memo
      @score = model.score
      @image_id = model.image_id
      @persisted = model.persisted?
    else
      @persisted = false
    end
    @image_uploaded = false
  end

  def apply(params)
    @title = params[:title]
    @memo = params[:memo]
    @score = params[:score]
    if params[:image].present?
      @image_uploaded = true
      @image_body = params[:image].read
      @image_filename = params[:image].original_filename
    end
  end

  def persisted?
    @persisted
  end

  def to_attributes
    {
      title: @title,
      memo: @memo,
      score: @score.to_i
    }
  end

  def to_image_attributes
    { body: @image_body, filename: @image_filename }
  end

  def image_uploaded?
    @image_uploaded
  end

  # What we want is extension of filename
  private def trim_image_filename(name)
    name_len = name.size
    return name if neme_len < MAXIMUM_FILENAME_SIZE
    start_offset = name_len - MAXIMUM_FILENAME_SIZE
    name[start_offset..]
  end

  private def validate_image
    if @image_uploaded && @image_body.size > Image::MAXIMUM_FILE_SIZE
      errors.add(:image, "can't be larger than #{number_to_human_size(Image::MAXIMUM_FILE_SIZE)}.")
    end
  end
end
