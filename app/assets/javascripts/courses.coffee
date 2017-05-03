# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#datepicker').datepicker
    minDate: 'today'
    maxDate: '+1M'
    showButtonPanel: true
    dateFormat: 'yy-mm-dd'
  return

$(document).ready ->
  $('.selectpicker').selectpicker
    style: 'form-control'
    maxOptions: 2
    size: 4
  return
# $(document).ready ->
#   $('.time').timepicker {}
#   return
# n
$(document).ready ->
  $('.time').timepicker
    timeFormat: 'HH:mm'
    interval: 30
    minTime: '07:00'
    maxTime: '23:00pm'
    defaultTime: '7'
    startTime: '07:00'
    dynamic: false
    dropdown: true
    scrollbar: true
  return
