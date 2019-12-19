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

   App.contracts.Housing.deployed().then(function(instance) {
 
   })

  },
    buyHouse: function(elem){
      $(function(){
       var firstAcc =  $(elem).parent().parent().children(':first-child').children(':last-child').text();
       var price =  $(elem).parent().parent().children(':first-child').children().eq("2").text();
       price = price.replace(/Kaina: /, "");
       price = price.substr(0, price.length-4);

        var acc =web3.eth.accounts;
        acc = acc[0];
        web3.eth.sendTransaction({to:firstAcc, from:acc, value:web3.toWei(price, "ether")}, function(err, transactionHash) {
           if (!err)
          console.log(transactionHash); // "0x7f9fade1c0d57a7af66ab4ead7c2eb7b11a91385"
          });
      })
    }


  
};
$(function() {
  $(window).load(function() {
    App.init();
  });
});
