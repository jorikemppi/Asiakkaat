<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js" charset="UTF-8"></script>
<title>Muuta asiakasta</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="2"><a id="takaisin" href="listaaasiakkaat.jsp">Takaisin listaukseen</a></th>
			</tr>	
			<tr>
				<th id="headerEtunimi">Etunimi</th>
				<th id="headerSukunimi">Sukunimi</th>
				<th id="headerPuhelin">Puhelin</th>
				<th id="headerSposti">Sposti</th>
				<th></th>							
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="button" id="tallenna" value="Hyväksy" onclick="paivitaTiedot()"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">	
</form>

<script>

function tutkiKeyX(event){
	if(event.keyCode = 13) {
		paivitaTiedot();
	}		
}

document.getElementById("etunimi").focus();

var asiakas_id = requestURLParam("asiakas_id");
fetch("asiakkaat/haeyksi/" + asiakas_id, {
	method: 'GET'
})
.then(function (response) {	
	return response.json()
})
.then(function (responseJson) {	
	document.getElementById("etunimi").value = responseJson.etunimi;	
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("sposti").value = responseJson.sposti;	
	document.getElementById("asiakas_id").value = responseJson.asiakas_id;	
});

function paivitaTiedot() {
	
	if (validoiTiedot() == 0) {
		return;
	}
	
	var formJsonStr = formDataToJSON(document.getElementById("tiedot"));
	fetch("asiakkaat", {
		method: 'PUT',
		body: formJsonStr
	})
	.then(function (response) {
		return response.json();
	})
	.then(function (responseJson) {
		var vastaus = responseJson.response;
		if (vastaus == 0) {
			document.getElementById("ilmo").innerHTML = "Asiakkaan muuttaminen epäonnistui.";
		} else if (vastaus == 1) {
			document.getElementById("ilmo").innerHTML = "Asiakkaan muuttaminen onnistui.";
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});
	//document.getElementById("tiedot").reset();
	
}

</script>

</body>
</html>