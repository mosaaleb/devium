class ChangeGenderTypeToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :profiles, :gender, 'integer USING CAST(gender AS integer)'
  end
end
