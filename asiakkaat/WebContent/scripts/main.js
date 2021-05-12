
function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

function formDataToJSON(data){
	var returnStr="{";
	for(var i=0; i<data.length; i++){		
		returnStr+="\"" +data[i].name + "\":\"" + data[i].value + "\",";
	}	
	returnStr = returnStr.substring(0, returnStr.length - 1); //poistetaan viimeinen pilkku
	returnStr+="}";
	return returnStr;
}	

function siivoa(teksti){
	teksti=teksti.replace("<","");
	teksti=teksti.replace(";","");
	teksti=teksti.replace("'","''");
	return teksti;
}

function validoiTiedot() {

	var ilmo = "";
	if (document.getElementById("etunimi").value.length < 2) {
		ilmo = "Liian lyhyt etunimi!";
		document.getElementById("headerEtunimi").style.backgroundColor = "red";
	}
	if (document.getElementById("sukunimi").value.length < 2) {
		ilmo = "Liian lyhyt sukunimi!";
		document.getElementById("headerSukunimi").style.backgroundColor = "red";
	}
	if (!(/^[0-9\-\(\)\s]*$/.test(document.getElementById("puhelin").value)) || (document.getElementById("puhelin").value.length < 5)) {
		ilmo = "Puhelinnumero ei kelpaa!";
		document.getElementById("headerPuhelin").style.backgroundColor = "red";
	}
	if (!(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(document.getElementById("sposti").value))) {
		ilmo = "Sähköposti ei kelpaa!";
		document.getElementById("headerSposti").style.backgroundColor = "red";
	}
	if (ilmo != "") {
		document.getElementById("ilmo").innerHTML = ilmo;
		document.getElementById("ilmo").style.backgroundColor = "red";
		setTimeout(function(){
			document.getElementById("ilmo").innerHTML = "";
			document.getElementById("ilmo").style.backgroundColor = "green";
			document.getElementById("headerEtunimi").style.backgroundColor = "green";
			document.getElementById("headerSukunimi").style.backgroundColor = "green";
			document.getElementById("headerPuhelin").style.backgroundColor = "green";
			document.getElementById("headerSposti").style.backgroundColor = "green";
		}, 5000);
		return 0;
	} else {
		document.getElementById("etunimi").value = siivoa(document.getElementById("etunimi").value);
		document.getElementById("sukunimi").value = siivoa(document.getElementById("sukunimi").value);
		document.getElementById("puhelin").value = siivoa(document.getElementById("puhelin").value);
		document.getElementById("sposti").value = siivoa(document.getElementById("sposti").value);
		return 1;
	}
}