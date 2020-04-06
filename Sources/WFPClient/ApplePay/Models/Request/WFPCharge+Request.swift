//
//  WFPCharge+Request.swift
//  PetsProjectApp
//
//  Created by Oleh Hudeichuk on 04.04.2020.
//  Copyright © 2020 Oleh Hudeichuk. All rights reserved.
//

import Foundation

public struct WFPChargeRequest: Codable {

    public var apiVersion: Int
    public var transactionType: WFPTransactionType
    public var merchantAccount: String
    public var merchantDomainName: String
    public var orderReference: String
    public var orderDate: Int64
    public var amount: Decimal
    public var currency: WFPCurrency
    public var productName: [String]
    public var productPrice: [Decimal]
    public var productCount: [Int]
    public var clientFirstName: String
    public var clientLastName: String
    public var clientCountry: String
    public var clientEmail: String
    public var clientPhone: String
    public var clientIpAddress: String
    public var merchantSignature: String
    public var merchantTransactionType: WFPMerchantTransactionType
    public var merchantTransactionSecureType: WFPMerchantTransactionSecureType
    public var applePayString: String
    public var socialUri: String
    /// max 1728000 sec;  min 60 sec
    public var holdTimeout: Int

    public init(apiVersion: Int = 1,
                transactionType: WFPTransactionType,
                merchantAccount: String,
                merchantDomainName: String,
                orderReference: String,
                orderDate: Int64,
                amount: Decimal = 0.0,
                currency: WFPCurrency,
                productName: [String] = [],
                productPrice: [Decimal] = [],
                productCount: [Int] = [],
                clientFirstName: String,
                clientLastName: String,
                clientCountry: String,
                clientEmail: String,
                clientPhone: String,
                clientIpAddress: String = "127.0.0.1",
                merchantSignature: String = "",
                merchantTransactionType: WFPMerchantTransactionType,
                merchantTransactionSecureType: WFPMerchantTransactionSecureType,
                applePayString: String = "",
                socialUri: String = "",
                holdTimeout: Int = 1_728_000
    ) {
        self.apiVersion = apiVersion
        self.transactionType = transactionType
        self.merchantAccount = merchantAccount
        self.merchantDomainName = merchantDomainName
        self.orderReference = orderReference
        self.orderDate = orderDate
        self.amount = amount
        self.currency = currency
        self.productName = productName
        self.productPrice = productPrice
        self.productCount = productCount
        self.clientFirstName = clientFirstName
        self.clientLastName = clientLastName
        self.clientCountry = clientCountry
        self.clientEmail = clientEmail
        self.clientPhone = clientPhone
        self.clientIpAddress = clientIpAddress
        self.merchantSignature = merchantSignature
        self.merchantTransactionType = merchantTransactionType
        self.merchantTransactionSecureType = merchantTransactionSecureType
        self.applePayString = applePayString
        self.socialUri = socialUri
        self.holdTimeout = holdTimeout
    }
}

