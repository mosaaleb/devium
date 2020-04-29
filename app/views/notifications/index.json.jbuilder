# frozen_string_literal: true

json.array! @notifications do |notification|
  json.id notification.id
  json.template render partial:
    'notifications/'\
    "#{notification.notifiable_type.underscore.pluralize}/"\
    "#{notification.notifier_type.underscore.sub(/e?$/, 'ed')}",
                       locals: { notification: notification }, formats: [:html]
end
