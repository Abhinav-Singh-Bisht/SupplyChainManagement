// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

// creating a library for structure of the supply chain
// It will contain enum for all the states i.e manufactured , shipped etc.

library Structure{

    enum State{
        Manufactured,
        PurchasedByDistributor,
        PurchasedByRetailer,
        PurchasedByCustomer
    }

    struct ManufacturerDetails{
        address manufacturer;
        string manufacturerName;
        string manufacturerAddress;
        uint256 manufacturedDate;
    }

    struct RetailerDetails{
        address retailer;
        string retailerName;
        string retailerAddress;
    }

    struct DistributorDetails{
        address distributor;
        string distributorName;
        string distributorAddress;
    }

    struct CustomerDetails{
        address customer;
        string customerName;
        string customerAddress;
    }

    struct ProductDetails{
        string productName;
        string productCategory;
        uint256 productCode;
        uint256 productPrice;
    }

    struct Product{
        uint256 uid;
        address owner;
        State productState;
        ManufacturerDetails manufacturer;
        RetailerDetails retailer;
        DistributorDetails distributor;
        CustomerDetails customer;
        ProductDetails productdet;
        string transaction;
    } 

    struct ProductHistory{
        Product[] history;
    }

    // struct Roles{
    //     bool Manufacturer;
    //     bool Retailer;
    //     bool Distributor;
    //     bool Customer;
    // }256
}