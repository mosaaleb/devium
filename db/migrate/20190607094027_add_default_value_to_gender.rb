class AddDefaultValueToGender < ActiveRecord::Migration[5.2]
  def change
    change_column_default :profiles, :gender, 0
  end
end
