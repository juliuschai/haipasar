var funcbtndialogalert = null;
function alertshow(msg,funcbtntemp){
  if(funcbtntemp!=null) funcbtndialogalert = funcbtntemp
  else funcbtndialogalert = null;
  document.getElementById('DialogAlertContent').innerHTML = msg;
  $('#DialogAlert').modal('show');
}
$('#DialogAlert').on('hidden.bs.modal', function (e) {
  if(funcbtndialogalert!=null)funcbtndialogalert();
});


var funcbtndialogconfirm = null;
// modal (DialogAlert)
function confirmshow(msg,funcbtntemp){
  funcbtndialogconfirm = null;
  document.getElementById('DialogConfirmContent').innerHTML = msg;
  document.getElementById('DialogConfirmBtnYes').onclick = funcbtntemp;
  $('#DialogConfirm').modal('show');
}

// modal DialogConfirm)
function confirmshow2btn(msg,funcbtntemp,funcbtntemp2){
  if(funcbtntemp2!=null) funcbtndialogconfirm = funcbtntemp2
  else funcbtndialogconfirm = null;

  document.getElementById('DialogConfirmContent').innerHTML = msg;
  document.getElementById('DialogConfirmBtnYes').onclick = funcbtntemp;
  $('#DialogConfirm').modal('show');
}
$('#DialogConfirm').on('hidden.bs.modal', function (e) {
  if(funcbtndialogconfirm!=null)funcbtndialogconfirm();
});