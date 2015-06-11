$ = jQuery
$ ->

$.tablesorter.addParser(
  id: 'timestamp'

  # Return false so this parser is not auto detected
  is: (s) ->
    false

  # Normalize the timestamp to epoch for sorting
  format: (s) ->
    moment.utc(s).unix()

  # The return value of our normalization function is an integer
  type: 'numeric'
)

$('.nodes').tablesorter(
  headers:
    2: sorter: 'timestamp'
    3: sorter: 'timestamp'
    4: sorter: false
  sortList: [[1,0]]
)

$('.facts').tablesorter(
  sortList: [[0,0]]
)

$('.dashboard').tablesorter(
  headers:
    2: sorter: 'timestamp'
    3: sorter: false
  sortList: [[0, 1]]
)

$('input.filter-table').parent('div').removeClass('hide')
$("input.filter-table").on "keyup", (e) ->
  rex = new RegExp($(this).val(), "i")

  $(".searchable tr").hide()
  $(".searchable tr").filter( ->
    rex.test $(this).text()
  ).show()

  if e.keyCode is 27
    $(e.currentTarget).val ""
    ev = $.Event("keyup")
    ev.keyCode = 13
    $(e.currentTarget).trigger(ev)
    e.currentTarget.blur()
