class AddImagePathToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :image_path, :string
  end
end
