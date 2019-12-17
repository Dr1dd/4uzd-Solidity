pragma solidity ^0.5.12;

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
    
    function sendOwnershipInquiry(uint House_number) payable public {
        require(msg.sender == buyer);
    
        /// Increment the order sequence
        ownershipseq++;
    
        /// Create the order register
        houses[ownershipseq] = Ownership(House_number, 0, 0, Registry(registor, 0, 0, buyer, 0, 0, false), true);
    
        /// Trigger the event
       emit sendOwnership(msg.sender, House_number, ownershipseq);
            
    }
    function getOwnershipInfo(uint number) public payable returns (address buyerAddr, uint House_number, uint orderno, uint safepay, uint delivery_price, uint delivey_safepay) {
    
    /// Validate the order number
    require(houses[number].init);

    /// Return the order data
    return(buyerAddr, houses[number].House_number, houses[number].price, houses[number].safepay, houses[number].registry.price, houses[number].registry.safepay);
  }
  function sendPrice(uint orderno, uint price, int8 ttype) payable public {
  
    /// Only the owner can use this function
    require(msg.sender == owner);

    /// Validate the order number
    require(houses[orderno].init);

    /// Validate the type
    ///  1=order
    ///  2=shipment
    require(ttype == 1 || ttype == 2);

    if(ttype == 1){/// Price for Order

      /// Update the order price
      houses[orderno].price = price;

    } else {/// Price for Shipment

      /// Update the shipment price
      houses[orderno].registry.price = price;
      houses[orderno].registry.init  = true;
    }

    /// Trigger the event
    emit PriceSent(buyer, orderno, price, ttype);

  }

  /// The function to send the value of order's price
  ///  This value will be blocked until the delivery of order
  ///  requires fee
  function sendSafepay(uint orderno) payable public {

    /// Validate the order number
    require(houses[orderno].init);

    /// Just the buyer can make safepay
    require(buyer == msg.sender);

    /// The order's value plus the shipment value must equal to msg.value
    require((houses[orderno].price + houses[orderno].registry.price) == msg.value);

    houses[orderno].safepay = msg.value;

    emit SafepaySent(msg.sender, orderno, msg.value, now);
  }
  function sendInvoice(uint orderno, uint delivery_date) payable public {

    require(houses[orderno].init);

    require(owner == msg.sender);

    invoiceseq++;

    invoices[invoiceseq] = Invoice(orderno, invoiceseq, true);

    houses[orderno].registry.date    = delivery_date;
    houses[orderno].registry.registor = registor;

   emit InvoiceSent(buyer, invoiceseq, orderno, delivery_date, registor);
  }

  function getInvoice(uint invoiceno) public returns (address buyer, uint delivery_date, address registor){
  
    require(invoices[invoiceno].init);

    Invoice storage _invoice = invoices[invoiceno];
    Ownership storage _currentOwner     = houses[_invoice.orderno];

    return (buyer, _currentOwner.registry.date, _currentOwner.registry.registor);
  }
    function delivery(uint invoiceno, uint timestamp) payable public {

    /// Validate the invoice number
    require(invoices[invoiceno].init);

    Invoice storage _invoice = invoices[invoiceno];
    Ownership storage _currentOwner     = houses[_invoice.orderno];

    /// Just the courier can call this function
    require(_currentOwner.registry.registor == msg.sender);

    emit OwnershipDelivered(buyer, invoiceno, timestamp, _currentOwner.registry.registor);

    /// Payout the Order to the seller
    owner.transfer(_currentOwner.safepay);

    /// Payout the Shipment to the courier
    _currentOwner.registry.registor.transfer(_currentOwner.registry.safepay);

  }
}