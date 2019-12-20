pragma solidity 0.5.12;

contract Housing {
    address payable public owner;

    address payable public buyer;

    address payable public registor;

    struct Buyer {
        address payable addr;
        string name;

        bool init;
    }
    struct Registor{
        address payable regAdrr;
        string regName;

        bool init;
    }
    struct Registry {
        address payable registor;
        uint price;
        uint safepay;
        address payer;
        uint date;
        uint real_date;

    bool init;
  }
  struct Ownership {
    uint House_number;
    uint price;
    uint safepay;
    Registry registry;

    bool init;
  }

  struct Invoice {
    uint orderno;
    uint number;

    bool init;
  }

    event sendOwnership(address payable buyer, uint House_number, uint orderno);

    event BuyerRegistered(address payable buyerAddr, string name);

    event RegistorRegistered(address payable registor, string regName);

    event PriceSent(address payable buyerAddr, uint orderno, uint price, int8 ttype);

    event SafepaySent(address payable buyer, uint orderno, uint value, uint now);

     event InvoiceSent(address payable buyerAddr, uint invoiceno, uint orderno, uint delivery_date, address payable registor);

    event OwnershipDelivered(address payable buyerAddr, uint orderno, uint real_delivey_date, address payable registor);

    constructor() public payable {

    owner = msg.sender;
   }
   function setBuyer(address payable addr) payable public{
    buyer = addr;
   }
   function setRegistor(address payable addr) payable public{
    registor = addr;
   }
    mapping (uint => Ownership) houses;
    mapping (uint => Invoice) invoices;
     uint ownershipseq;
       uint invoiceseq;

    function sendOwnershipInquiry(uint House_number) public {
        require(msg.sender == buyer);

        ownershipseq++;

        houses[ownershipseq] = Ownership(House_number, 0, 0, Registry(registor, 0, 0, buyer, 0, 0, false), true);


       emit sendOwnership(msg.sender, House_number, ownershipseq);

    }
    function getOwnershipInfo(uint number) public payable returns (address buyerAddr, uint House_number, uint orderno, uint safepay, uint delivery_price, uint delivey_safepay) {

    require(houses[number].init);

    return(buyerAddr, houses[number].House_number, houses[number].price, houses[number].safepay, houses[number].registry.price, houses[number].registry.safepay);
  }
  function sendPrice(uint orderno, uint price, int8 ttype) public {



    require(houses[orderno].init);

    require(ttype == 1 || ttype == 2);

    if(ttype == 1){

      houses[orderno].price = price;

    } else {

      houses[orderno].registry.price = price;
      houses[orderno].registry.init  = true;
    }

    emit PriceSent(buyer, orderno, price, ttype);

  }

  function sendSafepay(uint House_number) payable public {

    require(houses[House_number].init);

    require(buyer == msg.sender);

    require((houses[House_number].price + houses[House_number].registry.price) == msg.value);

    houses[House_number].safepay = msg.value;

    emit SafepaySent(msg.sender, House_number, msg.value, now);
  }
  function sendInvoice(uint House_number, uint delivery_date) public {

    require(houses[House_number].init);

    require(owner == msg.sender);

    invoiceseq++;

    invoices[invoiceseq] = Invoice(House_number, invoiceseq, true);

    houses[House_number].registry.date    = delivery_date;
    houses[House_number].registry.registor = registor;

   emit InvoiceSent(buyer, invoiceseq, House_number, delivery_date, registor);
  }

  function getInvoice(uint invoiceno) public returns (address buyer, uint delivery_date, address registor){

    require(invoices[invoiceno].init);

    Invoice storage _invoice = invoices[invoiceno];
    Ownership storage _currentOwner     = houses[_invoice.orderno];

    return (buyer, _currentOwner.registry.date, _currentOwner.registry.registor);
  }
    function delivery(uint invoiceno, uint timestamp) payable public {

    require(invoices[invoiceno].init);

    Invoice storage _invoice = invoices[invoiceno];
    Ownership storage _currentOwner     = houses[_invoice.orderno];

    require(_currentOwner.registry.registor == msg.sender);

    emit OwnershipDelivered(buyer, invoiceno, timestamp, _currentOwner.registry.registor);

    owner.transfer(_currentOwner.safepay);

    _currentOwner.registry.registor.transfer(_currentOwner.registry.safepay);

  }
} 