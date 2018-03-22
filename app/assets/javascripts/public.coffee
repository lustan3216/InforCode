window.growlNotify = (msg, type) ->
  type = type || "info";
  if (type == 'notice')
    type = 'success'
  if (type == 'alert')
    type = 'danger'
  $.bootstrapGrowl(msg, { type: type, align: 'right', offset: {from: 'bottom', amount: 30} });
