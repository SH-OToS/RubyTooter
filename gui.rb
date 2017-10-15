require './toot.rb'
require 'gtk2'

vis = "public"
cw = ""

account = {
  :token => "",
  :host => ""
}

body = "test"

account[:host] = "https://" + account[:host] + "/api/v1/statuses"




button_toot = Gtk::Button.new("Toot!")
button_exit = Gtk::Button.new("Exit")


button_toot.signal_connect("clicked") {
  body = $text_area.buffer.text
  PostToot(vis, cw, account, body)
  $text_area.buffer.text = ""
  $log_area.buffer.text = "#{$http_status_code}\n#{$http_msg}\n#{$http_body}"
}

button_exit.signal_connect("clicked") {
  Gtk.main_quit
  false
}

window = Gtk::Window.new
window.signal_connect("delete_event") {
  puts "delete event occurred"
  #true
  false
}


window.signal_connect("destroy") {
  puts "destroy event occurred"
  Gtk.main_quit
}


$text_area = Gtk::TextView.new
$text_area.set_size_request(200, 200)
$text_area.wrap_mode

$log_area = Gtk::TextView.new
$log_area.set_size_request(230, 200)


fixed = Gtk::Fixed.new
fixed.put($text_area, 5, 220)


box1 = Gtk::HBox.new(false, 0)

window.add(box1)

box1.pack_start(fixed, true, true, 0)
box1.pack_start($log_area, true, true, 0)
box1.pack_start(button_toot, true, true, 0)
box1.pack_start(button_exit, true, true, 0)


window.set_size_request(480, 600)
window.title = "RubyTooter"
window.border_width = 10
window.show_all

Gtk.main
