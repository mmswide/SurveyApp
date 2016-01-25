class AddDescriptionToEntitlement < ActiveRecord::Migration
  def change
    add_column :entitlements, :description, :string
  end
end
