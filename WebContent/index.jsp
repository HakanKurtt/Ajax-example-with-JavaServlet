<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <script type="text/javascript">
    <%@include file="js/jquery-3.3.1.min.js" %>
</script>
  <script type="text/javascript">
    <%@include file="js/bootstrap.js" %>
  </script>
  
  <style type="text/css">
    <%@include file="css/bootstrap.min.css" %>
  </style>
  
  
  
  
<script>
$(document).ready(function(){
	
	//Sayfa ilk açıldığında verileri veritabanından al.
	$.ajax({
		type:'GET',
		url:'ders?action=jsondata',
		headers:{
			Accept:"application/json; charset=utf-8",
			"Content-Type":"application/json; charset=utf-8"
		},
		success: function(result){
			var ders=$.parseJSON(result);
			
			//tabloda ilgili dersin verilerini veritabanından alma.
			$("td[id='kod']").text(ders.dersKodu);
			$("td[id='isim']").text(ders.dersAdi);
			
			//inputlara yazdırılacak verileri veritabanından alma.
			$("#dersAd").val(ders.dersAdi);
			$("#dersIcerik").val(ders.dersIcerik);
			$("#dersKod").val(ders.dersKodu);
		}
	});
	
	
	//XML butonuna tıklanınca veritabandaki veriyi XML formatında getirir.
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
		
		//JSON butonuna tıklanınca verileri veritabanından getir.
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
		
		//tuşa bastıkca veritabanına POST eder.
		$("#dersAd").keyup(function(e){
			if(e.which==16) // shift tusunu gormezden gel.
				return;
			var ad=$("#dersAd").val()
			var data={
					dersAd:ad,
					mod:"3"
			};
			
			
			$.ajax({
				type:'POST',
				url:'ders',
				data:data,
				success:function(){
					//Ders Adı değiştikçe veritabanından çek ve tabloya yaz.
					$.ajax({
						type:'GET',
						url:'ders?action=jsondata',
						headers:{
							Accept:"application/json; charset=utf-8",
							"Content-Type":"application/json; charset=utf-8"
						},
						success: function(result){
							var ders=$.parseJSON(result);
							//id degeri isim olan tablo hücresinin değerini değiştir.
							$("td[id='isim']").text(ders.dersAdi);
							
						}
					});
				}
			});
		});
		
		//tuşa bastıkca verileri veritabanına POST eder.
		$("#dersIcerik").keyup(function(e){
			if(e.which==16) // shift tusunu gormezden gel.
				return;
			var icerik=$("#dersIcerik").val()
			var data={
					dersIcerik:icerik,
					mod:"4"
			};
			$.ajax({
				type:'POST',
				url:'ders',
				data:data,
				success:function(){
					console.log("Basarili");
					
				}
			});
		});
		
		//tuşa bastıkça verileri veritabanına POST eder.
		$("#dersKod").keyup(function(e){
			if(e.which==16) // shift tusunu gormezden gel.
				return;
			var kod=$("#dersKod").val()
			var data={
					dersKodu:kod,
					mod:"2"
			};
			
			//Ders Kodu değiştikçe veritabanına yaz.
			$.ajax({
				type:'POST',
				url:'ders',
				data:data,
				success:function(){
					
					//**AJAXCEPTION**
					
					//Ders Kodu değiştikçe veritabanından çek ve tabloya yaz.
					$.ajax({
						type:'GET',
						url:'ders?action=jsondata',
						headers:{
							Accept:"application/json; charset=utf-8",
							"Content-Type":"application/json; charset=utf-8"
						},
						success: function(result){
							var ders=$.parseJSON(result);
							$("td[id='kod']").text(ders.dersKodu);
							
						}
					});
					
					
				}
			});
			
			
		});
		
		
		
	
});
</script>

</head>
<body>
<div class="container">
		
			<p>Ders Programı</p>
		
			<table id="dersler" class="table table-striped">
				<thead>
					<tr>
						<th>Sıra No</th>
						<th>Ders Kodu</th>
						<th>Ders Adı</th>
					</tr>
				</thead>
				
				<tbody>
					
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
					<!-- Ogrenci numarasının sonu 4 ile bittiğinden 4 numaralı dersin içeriğini veritabanından getir. -->
					<tr>
						<td>4</td>
						<td id="kod"></td>
						<td id="isim" data-toggle="collapse" data-target="#icerik" class="clickable"></td>
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
						
						<div class="row">
						
							<div class="col-md-3">
								<button id="xmlbutton" type="button" class="btn btn-light">XML Göster</button>
							</div>
							<div class="col-md-3">
								<button id="jsonbutton" type="button" class="btn btn-light">JSON Göster</button>
							</div>
						
						</div>
						</form>
					
						<div class="row">
							<label>Kodlanmış Veri</label><br/>
							<textarea id="veri"rows="10" cols="150">
					
							</textarea>
						</div>		
					
				</div> <!-- icerik bitis -->
			
	
</div> <!-- Container bitiş -->
	

</body>
</html>