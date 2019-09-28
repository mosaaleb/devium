# frozen_string_literal: true

json.actor notification.actor.fullname
json.action notification.action + ' on'
json.recipient notification.recipient.fullname
json.notifiable notification.notifiable.id
json.url post_path(notification.notifiable.post, anchor: dom_id(notification.notifiable))
