function Logout(){

    $.ajax({
      type: "get",
      url: "/logout",
      data: "",
      success: function (response) {
        if(response=='true'){
          location.reload();
        }else{
          alertshow('Data invalid',null);
        }
      }
    });
}

function LoadTemplate(sdiv,surl) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
          // window.history.pushState({},null, "/hallo.html");
          document.getElementById(sdiv).innerHTML = xhttp.responseText;
      }
  };
  xhttp.open("GET", surl, true);
  xhttp.send();
}