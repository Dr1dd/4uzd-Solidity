
$(function(){
	$("#addHouse").on("click", function(){	
		$("#pop").css("visibility", "visible");
	});
	$("#closepopup").on("click", function(){	
		$("#pop").css("visibility", "hidden");
	});
	$("#confirmAddHouse").on("click", function(){	
		var house_num = $("#house_num").val();
		var house_price = $("#house_price").val();
		var house_street = $("#house_street").val();
		var house_photo = $("#house_photo").val();
		var registor_address = $("#registor_address").val();
		var divAddress = document.getElementById("accounts");
		var selectedAcc = divAddress.options[divAddress.selectedIndex].value;

		var divElem =$("#allHouses");

		var div = document.createElement("div");
		var btnContain = document.createElement("div");
		var divnum = document.createElement("div");
		var divprice = document.createElement("div");
		var divstreet = document.createElement("div");
		var imgphoto = document.createElement("img");
		var divAddress = document.createElement("div");
		var divRegistorAddress = document.createElement("div");



		divnum.classList.add("houseText");
		divprice.classList.add("houseText");
		divstreet.classList.add("houseText");
		imgphoto.classList.add("housePhoto");
		divAddress.classList.add("houseText");
		divRegistorAddress.classList.add("houseText");

		btnContain.classList.add("btnCont");

		console.log(selectedAcc);
		divnum.innerHTML = "Numeris: "+ house_num;
		divprice.innerHTML = "Kaina: "+ house_price +" ETH";
		divstreet.innerHTML = "Gatvė: " + house_street;
		divRegistorAddress.innerHTML = "Registratorius: "+ registor_address;

		imgphoto.setAttribute("src", house_photo);
		var adress =document.createElement("span");
		adress.innerHTML = "Adresas:";

		divAddress.innerHTML = selectedAcc;

		div.classList.add("houseBlock");
		div.append(imgphoto);
		div.append(divnum);
		div.append(divprice);
		div.append(divstreet);
		div.append(adress);
		div.append(divAddress);
		div.append(divRegistorAddress);

		var btn = document.createElement("div");
		btn.innerHTML = "Pirkti";
		btn.classList.add("btn");
		btn.setAttribute("onclick", "App.buyHouse(this)")
		btnContain.append(btn);

		divMaster = document.createElement("div")
	    divMaster.append(div);
		divMaster.classList.add("house");
		divMaster.append(btnContain);

	    divElem.append(divMaster);
	    $("#pop").css("visibility", "hidden");
	});

});