<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<title>Asiakkaat</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
<form id="tiedot">
	<table id="listaus">
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>	
			<tr>
				<th class="oikealle" colspan="3">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" value="hae" id="hakunappi"></th>
			</tr>			
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
				<th></th>						
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Hyväksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">	
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function() {
	
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	var asiakas_id = requestURLParam("asiakas_id");
	$.ajax({url:"asiakkaat/haeyksi/" + asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#asiakas_id").val(asiakas_id);
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);			
    }});
	
	jQuery.validator.addMethod("phone", function(value, element){
		return this.optional( element ) || /^[0-9\-\(\)\s]*$/.test( value );
	}, "Ei kelpaa"); 
	
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true,
				minlength: 2				
			},
			sukunimi: {
				required: true,
				minlength: 2
			},
			puhelin:  {
				required: true,
				phone: true,
				minlength: 7				
			},
			sposti: {
				required: true,
				email: true,
				minlength: 6
			}
		},
		messages: {
			etunimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				email: "Ei kelpaa",
				minlength: "Liian lyhyt"
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 	
});
	
function paivitaTiedot() {	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if (result.response == 0) {
      		$("#ilmo").html("Henkilön päivittäminen epäonnistui.");
      	} else if (result.response == 1) {			
      		$("#ilmo").html("Henkilön päivittäminen onnistui.");
      		$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  	}
  	}});	
}

</script>

</body>
</html>