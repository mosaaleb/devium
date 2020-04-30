class Notification
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      notification.template

    $("[data-behavior='unread-count']").text(items.length)
    $("[data-behavior='notification-items']").append(items)
    $("[data-behavior='notification-link-item']").on 'click', @markAsRead

  markAsRead: (e) =>
    $.ajax(
      url: "/notifications/#{e.currentTarget.id}/mark_as_read"
      dataType: "JSON"
      data: { authenticity_token: $('[name="csrf-token"]')[0].content }
      method: "POST"
      success: @updateNotificationCount
    )

  updateNotificationCount: () =>
    $("[data-behavior='unread-count']").text(length - 1)

jQuery ->
  new Notification
