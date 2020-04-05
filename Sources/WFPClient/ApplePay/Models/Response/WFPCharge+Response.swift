//
//  WFPCharge+Response.swift
//  PetsProjectApp
//
//  Created by Oleh Hudeichuk on 04.04.2020.
//  Copyright © 2020 Oleh Hudeichuk. All rights reserved.
//

public struct WFPChargeResponse: Codable {

    public var reason: String
    public var reasonCode: WFPReasonCode
    public var merchantAccount: String?
    public var authTicket: String?
    public var orderReference: String?
    public var merchantSignature: String?
    public var amount: Double?
    public var currency: WFPCurrency?
    public var authCode: String?
    public var email: String?
    public var phone: String?
    public var createdDate: Int?
    public var processingDate: Int?
    public var cardPan: String?
    public var cardType: String?
    public var issuerBankCountry: String?
    public var issuerBankName: String?
    public var recToken: String?
    public var transactionStatus: WFPTransactionStatus?
    public var fee: Double?
    public var paymentSystem: String?
    public var merchantTransactionType: WFPMerchantTransactionType?
    public var d3AcsUrl: String?
    public var d3Md: String?
    public var d3Pareq: String?
    public var returnUrl: String?
}
