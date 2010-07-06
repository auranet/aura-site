class MediaFile < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    content_type :string
    filename     :string
    size         :integer
    timestamps
  end

  has_attachment :storage => :file_system,
                 :max_size => 100.megabytes,
                 :path_prefix => "public/media_files"

  validates_as_attachment

  def name
    self.public_filename
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end
end
