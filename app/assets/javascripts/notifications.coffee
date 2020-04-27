class Notification
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    # $("[data-behavior='notification-link']").on "click", mark_as_read
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      "
      <a class='dropdown-item nav-link' href=#{notification.notification_url}>
        #{notification.actor}
        #{notification.action}
        #{notification.post_author}
        #{notification.notifier}
      </a>
      "

    $("[data-behavior='unread-count']").text(items.length)
    $("[data-behavior='notification-items']").prepend(items)

  mark_as_read: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='unread-count']").text(items.length - 1)
    )

jQuery ->
  new Notification
