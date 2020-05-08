// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require chartkick
//= require Chart.bundle
//= require materialize
//= require activestorage
//= require_tree .


$(document).ready(function(){
	$('select').formSelect();
	$('.sidenav').sidenav();
	$('.tabs').tabs();
	$('.tooltipped').tooltip();
	$('.modal').modal();
	$('.datepicker').datepicker({
		i18n:{
			months:["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
			weekdays: ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"],
        },
        format: "yyyy-mm-dd"
	});
});
