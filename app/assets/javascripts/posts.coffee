console.log("init Blend4Web")
m_app = b4w.require("app")
m_data = b4w.require("data")
m_container = b4w.require("container")
m_anchors = b4w.require("anchors")
m_main = b4w.require("main")
m_ctl = b4w.require("controls")

$ ->
  $(window).resize ->
    w = $(window).width()
    h = $(window).height()
    console.log("resizing container")
    m_container.resize_to_container()
    console.log($(window).width())
    if $(window).width() > 828
      console.log("one row")
    else if $(window).width() < 828 && $(window).width() >= 768
      console.log("two rows")
    else if $(window).width() < 768
      console.log("three rows")

jQuery(document).ready ($) ->

  m_app.init({
    canvas_container_id: "b4w-overlay",
    callback: init_cb
})

init_cb = ->
  m_data.load("/all-floors.json", load_cb)
  rotate_right_arrow = m_ctl.create_custom_sensor(0)
  rotate_left_arrow = m_ctl.create_custom_sensor(0)
  rotate_up_arrow = m_ctl.create_custom_sensor(0)
  rotate_down_arrow = m_ctl.create_custom_sensor(0)
  pan_right_arrow = m_ctl.create_custom_sensor(0)
  pan_left_arrow = m_ctl.create_custom_sensor(0)
  pan_up_arrow = m_ctl.create_custom_sensor(0)
  pan_down_arrow = m_ctl.create_custom_sensor(0)
  document.getElementById("b4w-overlay").addEventListener("touchstart", touch_start_cb, false)
  document.getElementById("b4w-overlay").addEventListener("touchmove", touch_move_cb, false)
  document.getElementById("b4w-overlay").addEventListener("touchend", touch_end_cb, false)

load_cb = ->
  m_app.enable_camera_controls()

touch_start_cb = (event) ->
  console.log("touch start event")
  event.preventDefault()
  h = window.innerHeight
  w = window.innerWidth
  touches = event.changedTouches
  i = 0
  while i < touches.length
    touch = touches[i]
    x = touch.clientX
    y = touch.clientY
    console.log("touch event, x: " + x.toString() + " y: " + y.toString())
    i++
  return

touch_move_cb = (event) ->
  console.log("touch move event")
  return

touch_end_cb = (event) ->
  console.log("touch end event")
  return

window.oncontextmenu = (e) ->
  e.preventDefault()
  e.stopPropagation()
  false
