App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',
  hasVoted: false,

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(App.web3Provider);
    }
    return App.initContract();
  },

  initContract: function() {
    $.getJSON("Housing.json", function(housing) {
      App.contracts.Housing = TruffleContract(housing);
      App.contracts.Housing.setProvider(App.web3Provider);

      App.listenForEvents();

      return App.render();
    });
  },

  listenForEvents: function() {
    App.contracts.Housing.deployed().then(function(instance) {

    });
    window.addEventListener('load', async () => {
    try {
            await ethereum.enable();
           } catch (error) {}
    });
  },

  render: function() {

    var acc =web3.eth.accounts;

          var opt = document.createElement("option");
          opt.setAttribute("value", acc);
          opt.innerHTML = acc;
          document.getElementById("accounts").appendChild(opt);


  },
    buyHouse: function(elem){
      $(function(){
       var firstAcc =  $(elem).parent().parent().children(':first-child').children().eq("-2").text();
       var price =  $(elem).parent().parent().children(':first-child').children().eq("2").text();
       var house_number =  $(elem).parent().parent().children(':first-child').children().eq("1").text();
       var registor =  $(elem).parent().parent().children(':first-child').children().eq("-1").text();
      
       house_number = house_number.replace(/Numeris: /, "");
       registor = registor.replace(/Registratorius: /, "");
       price = price.replace(/Kaina: /, "");
       price = price.substr(0, price.length-4);

        var acc =web3.eth.accounts;
        acc = acc[0];
          App.contracts.Housing.deployed().then(function(data) {
             var instance = data;
             console.log("1");
             return instance.setBuyer(acc);
           });
          App.contracts.Housing.deployed().then(function(data2) {
           var instance1 = data2;
             console.log("2");

            return instance1.setRegistor(registor);
           });
          App.contracts.Housing.deployed().then(function(data3){
            var ownershipInstance = data3;
             console.log("3");

            return ownershipInstance.sendOwnershipInquiry(house_number);
           });
           // App.contracts.Housing.deployed().then(function(data4){
           //  var send1 = data4;     
           //   console.log("4");

           //       return send1.sendPrice(parseInt(house_number), parseInt(price), 1);                  
           // });
           // App.contracts.Housing.deployed().then(function(data5) {
           //  var send2 =data5;
           //   console.log("5");

           //   return send2.sendPrice(house_number, 0.5 , 2);
           // });
           //  App.contracts.Housing.deployed().then(function(data6){
           //  var send3 =data6;
           //   console.log("6");

           //    return send3.sendSafepay(house_number);
           // });
           //   App.contracts.Housing.deployed().then(function(data7){
           //   var send4 =data7;
           //   return send4.sendInvoice(house_number, "2019");
           // });
           //   App.contracts.Housing.deployed().then(function(data8) {   
           //   var send5 =data8;
           //   return send5.delivery(house_number, "2019");
           // });
        });

      
      
    },
    sendPrice: function(){
      App.contracts.Housing.deployed().then(function(data4){
            var send1 = data4;     
             console.log("4");
       return send1.sendPrice(parseInt(house_number), parseInt(price), 1);                  
     });
    }

  
};
$(function() {
  $(window).load(function() {
    App.init();
  });
});
