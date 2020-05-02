# frozen_string_literal: true

module FacebookOmniauthable
  def from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email = auth.info.email
      user.username = auth.info.name.titlecase.split.join

      user.build_profile(
        first_name: auth.info.name.split(' ')[0],
        last_name: auth.info.name.split(' ')[1],
        image_path: auth.info.image
      )
    end
  end

  def new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) &&
         (session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
