class Menu < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    url :string
    is_public :boolean, :default => true
    order_number :integer
    timestamps
  end

  belongs_to :menu
  has_many :menus

  default_scope :order => "order_number, name"

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
