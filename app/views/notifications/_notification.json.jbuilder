# frozen_string_literal: true

json.actor notification.actor.fullname
json.action notification.action + ' on'
json.post_author notification_original_author_name(notification.notifiable.post.user)
json.notifier 'post'
json.notifiable notification.notifiable.comment_content
json.notifiction_url post_path(notification.notifiable.post, anchor: dom_id(notification.notifiable))
