# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#pending_tasks_list table tr:gt(0)").draggable
    delay: 200
    revert: "invalid"
    helper: "clone"

  $("#completed_tasks_list table tr:gt(0)").draggable
    delay: 200
    revert: "invalid"
    helper: "clone"

  $("#pending_tasks_list").droppable drop: (event, ui) ->
    c = $(ui.draggable).find("td:eq(1) a").attr("href")
    location.href = c

  $("#completed_tasks_list").droppable drop: (event, ui) ->
    c = $(ui.draggable).find("td:eq(1) a").attr("href")
    location.href = c
