<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js" charset="UTF-8"></script>
<title>Asiakkaat</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body onkeydown="tutkiKey(event)">
<table id="listaus">
	<thead>
		<tr>
			<th colspan="4" id="ilmo"></th>
			<th><a id="uusiAsiakas" href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
		</tr>	
		<tr>
			<th class="oikealle" colspan="3">Hakusana:</th>
			<th><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi" onclick="haeAsiakkaat()"></th>
		</tr>			
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th></th>						
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>

<script>

haeAsiakkaat();
document.getElementById("hakusana").focus();

function tutkiKey(event) {
	if (event.keyCode == 13) {
		haeAsiakkaat();
	}
}

function haeAsiakkaat() {
	fetch("asiakkaat/" + document.getElementById("hakusana").value, {
		method: 'GET'
	})
	.then(function (response) {
		return response.json()
	})
	.then(function (responseJson) {		
		var asiakkaat = responseJson.asiakkaat;		
		var htmlStr = "";		
		for (var i = 0; i < asiakkaat.length; i++) {
			htmlStr += "<tr id='rivi_" + asiakkaat[i].asiakas_id + "'>";
        	htmlStr += "<td>" + asiakkaat[i].etunimi + "</td>";
        	htmlStr += "<td>" + asiakkaat[i].sukunimi + "</td>";
        	htmlStr += "<td>" + asiakkaat[i].puhelin + "</td>";
        	htmlStr += "<td>" + asiakkaat[i].sposti + "</td>";
        	htmlStr += "<td><a href='muutaasiakas.jsp?asiakas_id=" + asiakkaat[i].asiakas_id +"'>Muuta</a>&nbsp;";
        	htmlStr += "<span class='poista' onclick=poista('" + asiakkaat[i].asiakas_id + "','" + asiakkaat[i].etunimi + "','" + asiakkaat[i].sukunimi + "')>Poista</span></td>";
        	htmlStr += "</tr>";
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})
}

function poista(asiakas_id, etunimi, sukunimi) {
	
	if (confirm("Poista " + etunimi + " " + sukunimi + "?")) {
		
		fetch("asiakkaat/" + asiakas_id, {
			method: 'DELETE'
		})
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {
			var vastaus = responseJson.response;
			if (vastaus == 0) {
				document.getElementById("ilmo").innerHTML = "Asiakkaan poisto epäonnistui.";
			} else if (vastaus == 1) {
				document.getElementById("ilmo").innerHTML = "Asiakkaan " + etunimi + " " + sukunimi + " poisto onnistui.";
				document.getElementById("rivi_" + asiakas_id).style.backgroundColor = "red";
				setTimeout(function(){haeAsiakkaat();}, 500);
			}
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})
	}

}

</script>

</body>
</html>