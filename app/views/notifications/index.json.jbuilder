# frozen_string_literal: true

# json.array! @notifications, partial: 'notifications/notification', as: :notification

json.array! @notifications do |notification|
  json.id notification.id
  json.template render partial:
    "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}",
                       locals: { notification: notification }, formats: [:html]
end
