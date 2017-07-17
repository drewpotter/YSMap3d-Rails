console.log("init Blend4Web")
m_app = b4w.require("app")
m_data = b4w.require("data")
m_cont = b4w.require("container")
m_anchors = b4w.require("anchors")
m_main = b4w.require("main")
m_ctl = b4w.require("controls")

vec2_tmp = new Float32Array(2)
control_rotate_circle = undefined
control_pan_circle = undefined
control_pan_analog_stick = undefined
control_rotate_analog_stick = undefined
control_rotate_circle_offset = undefined
control_rotate_analog_stick_offset = undefined
control_pan_circle_offset = undefined
control_pan_analog_stick_offset = undefined

$ ->
  $(window).resize ->
    w = $(window).width()
    h = $(window).height()
    console.log("resizing container")
    m_cont.resize_to_container()
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
  control_rotate_circle = document.getElementById("control_rotate_circle")
  control_pan_circle = document.getElementById("control_pan_circle")
  control_pan_analog_stick = document.getElementById("control_pan_analog_stick")
  control_rotate_analog_stick = document.getElementById("control_rotate_analog_stick")
  control_rotate_circle_offset = control_rotate_circle.clientWidth / 2
  control_pan_circle_offset = control_pan_circle.clientWidth / 2
  control_pan_analog_stick_offset = control_pan_analog_stick.clientWidth / 2
  control_rotate_analog_stick_offset = control_rotate_analog_stick.clientWidth / 2

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
    client_x = touch.clientX
    client_y = touch.clientY
    console.log("touch event client, x: " + client_x.toString() + " y: " + client_y.toString())
    canvas_xy = m_cont.client_to_canvas_coords(client_x, client_y, vec2_tmp)
    x = canvas_xy[0]
    y = canvas_xy[1]
    console.log("touch event, x: " + x.toString() + " y: " + y.toString())

    if(x > w / 2)
      console.log("right hand side")
      control_rotate_circle.style.left = x - control_rotate_circle_offset + "px"
      control_rotate_circle.style.top = y - control_rotate_circle_offset + "px"
      control_rotate_analog_stick.style.left = x - control_rotate_analog_stick_offset + "px"
      control_rotate_analog_stick.style.top = y - control_rotate_analog_stick_offset + "px"
      control_rotate_circle.style.visibility = "visible"
      control_rotate_analog_stick.style.visibility = "visible"

    else
      console.log("left hand side")
      control_pan_circle.style.left = x - control_pan_circle_offset + "px"
      control_pan_circle.style.top = y - control_pan_circle_offset + "px"
      control_pan_analog_stick.style.left = x - control_pan_analog_stick_offset + "px"
      control_pan_analog_stick.style.top = y - control_pan_analog_stick_offset + "px"
      control_pan_circle.style.visibility = "visible"
      control_pan_analog_stick.style.visibility = "visible"

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
