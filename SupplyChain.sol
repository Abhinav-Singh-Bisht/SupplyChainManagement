// SPDX-License-Identifier: MIT

pragma solidity  >=0.7.0 <0.9.0;
import "./Structure.sol";
import "./Manufacturer.sol";
import "./Distributor.sol";
import "./Retailer.sol";
import "./Customer.sol";
import "./Roles.sol";


contract SuppyChain is Manufacturer , Distributor , Retailer , Customer{

    // MANUFACTURER
    // // Register as a manufacturer
    // function addManufacturer() public{
    //     addManufacturer(msg.sender);
    // }
    // // Remove from manufacturer
    // function removeManufacturer()  public{
    //     removeManufacturer(msg.sender);
    // }


    // // RETAILER
    // // Register as a manufacturer
    // function addRetailer() public {
    //     addRetailer(msg.sender);
    // }
    
    // // Remove from manufacturer
    // function removeRetailer() public {
    //     removeRetailer(msg.sender);
    // }


    // // DISTRIBUTOR
    // // Register as a manufacturer
    // function addDistributor() public {
    //     addDistributor(msg.sender);
    // }

    // // Remove from manufacturer
    // function removeDistributor() public{
    //     removeDistributor(msg.sender);
    // }


    // // CUSTOMER
    // // Register as a manufacturer
    // function addCustomer() public{
    //     addCustomer(msg.sender);
    // }

    // // Remove from manufacturer
    // function removeCustomer() public{
    //     removeCustomer(msg.sender);
    // }


    // For keeping a list of products and their history
    mapping(uint256 => Structure.Product) productsList;
    mapping(uint256 => Structure.ProductHistory) product_history;


    // Events
    // event ManufacturerAdded(address indexed _account);
    // event RetailerAdded(address indexed _account);
    // event DistributorAdded(address indexed _account);
    // event CustomerAdded(address indexed _account);

    // // state Events
    event eManufactured(uint256 uid);
    event ePurchasedByDistributor(uint256 uid);
    event ePurchasedByRetailer(uint256 uid);
    event ePurchasedByCustomer(uint256 uid);


    // Creating modifiers to check if the prodcut cleared
    // previous state
    
    modifier mManufactured(uint256 _uid){
        require(productsList[_uid].productState == Structure.State.Manufactured);
        _;
    }

    modifier mPurchasedByDistributor(uint256 _uid){
        require(productsList[_uid].productState == Structure.State.PurchasedByDistributor);
        _;
    }

    modifier mPurchasedByRetailer(uint256 _uid){
        require(productsList[_uid].productState == Structure.State.PurchasedByRetailer);
        _;
    }


    modifier mPurchasedByCustomer(uint256 _uid){
        require(productsList[_uid].productState == Structure.State.PurchasedByCustomer);
        _;
    }

    modifier mVerifyAddress(address _account,address _owner){
        require(_account == _owner);
        _;
    }

    function ReturnProductHistory(uint256 _uid) external view returns(Structure.Product[] memory){
        return product_history[_uid].history;
    } 

    // Step 1 Manufacture a Product
    function ManufactureProduct(
        uint256 _uid,
        address _account,
        uint256 productCode,
        uint256 productPrice,
        string memory productCategory,
        string memory productName,
        address manufacturer,
        string memory manufacturerName,
        string memory manufacturerAddress,
        uint256 manufacturedDate
    ) public {

        require(isManufacturer(_account));
        Structure.Product memory product;

        product.uid = _uid;
        product.owner = _account;
        product.productState = Structure.State.Manufactured;
        product.productdet.productName = productName;
        product.productdet.productCategory = productCategory;
        product.productdet.productCode = productCode;
        product.productdet.productPrice = productPrice; 

        product.manufacturer.manufacturer = manufacturer;
        product.manufacturer.manufacturerName = manufacturerName;
        product.manufacturer.manufacturerAddress = manufacturerAddress;
        product.manufacturer.manufacturedDate = manufacturedDate;

        productsList[_uid] = product;
        product_history[_uid].history.push(product);

        emit eManufactured(_uid);
    }

    // Step 2 Purchase of Product by Distributor
    function PurchasedByDistributor(
        address _account,
        uint256 _uid,
        string memory distributorName,
        string memory distributorAddress
        ) public mManufactured(_uid){
        
        require(isDistributor(_account));
        productsList[_uid].owner = _account;
        productsList[_uid].productState = Structure.State.PurchasedByDistributor;

        productsList[_uid].distributor.distributor = _account;
        productsList[_uid].distributor.distributorName = distributorName;
        productsList[_uid].distributor.distributorAddress = distributorAddress;

        product_history[_uid].history.push(productsList[_uid]);

        emit ePurchasedByDistributor(_uid);
    }
 
    // STEP 3 Purchase of Product by Retailer
    function PurchasedByRetailer(
        address _account,
        uint256 _uid,
        string memory retailerName,
        string memory retailerAddress
    ) public mPurchasedByDistributor(_uid){
        require(isRetailer(_account));

        productsList[_uid].owner = _account;
        productsList[_uid].productState = Structure.State.PurchasedByRetailer;

        productsList[_uid].retailer.retailer = _account;
        productsList[_uid].retailer.retailerName = retailerName;
        productsList[_uid].retailer.retailerAddress = retailerAddress;

        product_history[_uid].history.push(productsList[_uid]);

        emit ePurchasedByRetailer(_uid);
    }

    // STEP 4 PurchasedByCustomer
    function PurchasedByCustomer(
        address _account,
        uint256 _uid,
        string memory customerName,
        string memory customerAddress
    ) public mPurchasedByRetailer(_uid){
        require(isCustomer(_account));

        productsList[_uid].owner = msg.sender;
        productsList[_uid].productState = Structure.State.PurchasedByCustomer;

        productsList[_uid].customer.customer = msg.sender;
        productsList[_uid].customer.customerName = customerName;
        productsList[_uid].customer.customerAddress = customerAddress;

        product_history[_uid].history.push(productsList[_uid]);

        emit ePurchasedByCustomer(_uid);
    }

}