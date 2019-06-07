class RemoveDefaultValueFromGender < ActiveRecord::Migration[5.2]
  def change
    change_column_default :profiles, :gender, from: 0, to: nil
  end
end
