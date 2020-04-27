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
    $("[data-behavior='notification-items']").prepend(items)

jQuery ->
  new Notification
