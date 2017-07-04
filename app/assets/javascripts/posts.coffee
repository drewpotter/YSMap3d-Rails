console.log("init Blend4Web")
m_app = b4w.require("app");
m_data = b4w.require("data");
m_container = b4w.require("container");
m_anchors = b4w.require("anchors");
m_main  = b4w.require("main");

$ ->
  $(window).resize ->
    w = $(window).width()
    h = $(window).height()
    console.log("resizing container")
    m_container.resize_to_container();
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

load_cb = ->
  m_app.enable_camera_controls()

window.oncontextmenu = (e) ->
  e.preventDefault()
  e.stopPropagation()
  false
