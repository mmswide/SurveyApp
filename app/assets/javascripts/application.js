// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/datepicker
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require tinymce-jquery
//= require cocoon
//= require jquery.sortable
//= require jquery.purr
//= require best_in_place
//= require best_in_place.jquery-ui
//= require best_in_place.purr
//= require pace-master/pace.min
//= require jquery-blockui/jquery.blockui
//= require jquery-slimscroll/jquery.slimscroll.min
//= require switchery/switchery.min
//= require uniform/js/jquery.uniform.standalone
//= require offcanvasmenueffects/js/classie
//= require waves/waves.min
//= require 3d-bold-navigation/js/modernizr
//= require 3d-bold-navigation/js/main
//= require waypoints/jquery.waypoints.min
//= require toastr/toastr.min
//= require flot/jquery.flot.min
//= require flot/jquery.flot.time.min
//= require flot/jquery.flot.symbol.min
//= require flot/jquery.flot.resize.min
//= require flot/jquery.flot.tooltip.min
//= require curvedlines/curvedLines
//= require meteor
//= require custom
//= require_tree .

$(document).ready(function(){
  $.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd'
  });
});
