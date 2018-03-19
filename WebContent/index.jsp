<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ders Seçimi</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script>
$(document).ready(function(){
	
	$.ajax({
		type:'GET',
		url:'ders?action=jsondata',
		headers:{
			Accept:"application/json; charset=utf-8",
			"Content-Type":"application/json; charset=utf-8"
		},
		success: function(result){
			var ders=$.parseJSON(result);
			
			
			$("#dersAd").val(ders.dersAdi);
			$("#dersIcerik").val(ders.dersIcerik);
			$("#dersKod").val(ders.dersKodu);
		}
	});
	
	$("#xmlbutton").click(function(){
		$.ajax({
			type:'GET',
			url:'ders?action=xmldata',
			headers:{
				Accept:"application/xml; charset=utf-8",
				"Content-Type":"application/xml; charset=utf-8"
			},
			success: function(xmlData){
				var xmlString;
			    //IE
			    if (window.ActiveXObject){
			        xmlString = xmlData.xml;
			    }
			    // Mozilla, Firefox, Opera, vs. için kod.
			    else{
			        xmlString = (new XMLSerializer()).serializeToString(xmlData);
			    }
			    $("#veri").val(xmlString);
			}
		});
	});
		
		
		$("#jsonbutton").click(function(){
			$.ajax({
				type:'GET',
				url:'ders?action=jsondata',
				headers:{
					Accept:"application/json; charset=utf-8",
					"Content-Type":"application/json; charset=utf-8"
				},
				success: function(result){
					var ders=$.parseJSON(result);
					var data= JSON.stringify(ders);
					$("#veri").val(result);
					
				}
			});
		});
		
		$("#dersAd").keyup(function(){
			alert("Bir tuşa basıp bıraktınız");
		});
		
		
});
</script>

</head>
<body>
<div class="container">

		<div class="row">
		
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<td>Ders Programı</td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<th>Sıra No</th>
						<th>Ders Kodu</th>
						<th>Ders Adı</th>
					</tr>
					
					<tr>
						<td>0</td>
						<td>BSM 103</td>
						<td>Programlamaya Giriş</td>
					</tr>
					
					<tr>
						<td>1</td>
						<td>BSM 201</td>
						<td>Elektrik Devre Temelleri</td>
					</tr>
					
					<tr>
						<td>2</td>
						<td>BSM 205</td>
						<td>Web Programlama</td>
					</tr>
					
					<tr>
						<td>3</td>
						<td>BSM 309</td>
						<td>İşletim Sistemleri</td>
					</tr>
					
					<tr>
						<td>4</td>
						<td>BSM 458</td>
						<td><a href="#icerik" data-toggle="collapse">Ağ Programlama</a></td>
					</tr>
					
					
				
				</tbody>
			</table>
			
			
			<div id="icerik" class="collapse">
			<form>
				<div class="form-group row">
					<label for="dersKod" class="col-sm-1 label label-default">Dersin Kodu</label>
					<div class="col-sm-11">
						<input type="text" class="form-control form-control-sm" id="dersKod" >
					</div>
				</div>
				
				<div class="form-group row">
					
					<label for="dersAd" class="col-sm-1 label label-default">Dersin Adı</label>
					<div class="col-sm-11">
						<input type="text" id="dersAd" class="form-control form-control-sm" >
					</div>
				</div>
				
				<div class="form-group row">
					<label for="dersIcerik" class="col-sm-1 label label-default">Dersin İçeriği</label>
					
					<div class="col-sm-11">
						<input id="dersIcerik" type="text" class="form-control form-control-sm">
					</div>
				</div>
				
				<div>
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
						<button id="xmlbutton" type="button" class="btn btn-light pull-right">XML Göster</button>
					</div>
					<div class="col-lg-4 col-md-6 col-sm-6 col-xs-6 col-lg-offset-2">
						<button id="jsonbutton" type="button" class="btn btn-light">JSON Göster</button>
					</div>
				
				
				</form>
			
				<label>Kodlanmış Veri</label><br/>
				<textarea id="veri"rows="10" cols="150">
			
				</textarea>
			
				</div> 
			
		
			</div><!-- icerik bitis -->

	</div>

</body>
</html>