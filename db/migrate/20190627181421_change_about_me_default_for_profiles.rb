class ChangeAboutMeDefaultForProfiles < ActiveRecord::Migration[5.2]
  def change
    change_column_default :profiles, :about_me, from: nil, to: "Apparently, this user prefers to keep an air of mystery about them."
    
    reversible do |dir|
      Profile.find_each do |profile|
        dir.up do
          profile.update about_me: "Apparently, this user prefers to keep an air of mystery about them."
        end
        dir.down do
          profile.update about_me: nil
        end
      end
    end

  end
end
