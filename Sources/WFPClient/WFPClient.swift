//
//  WayForPay.swift
//  PetsProjectApp
//
//  Created by Oleh Hudeichuk on 04.04.2020.
//  Copyright © 2020 Oleh Hudeichuk. All rights reserved.
//

import SwiftExtensionsPack
import Foundation

open class WFPClient {

    public var apiURL: URL
    public var httpClient: WFPHttpClientPrtcl
    public var request: WFPChargeRequest
    public var secretKey: String
    public var isSigned: Bool {
        !request.merchantSignature.isEmpty
    }

    public init(apiURL: URL, httpClient: WFPHttpClientPrtcl = WFPHttpClient(), request: WFPChargeRequest, secretKey: String) {
        self.apiURL = apiURL
        self.request = request
        self.secretKey = secretKey
        self.httpClient = httpClient
    }

    public func addProduct(name: String, price: Decimal, count: Int) {
        request.productName.append(name)
        request.productPrice.append(price)
        request.productCount.append(count)
        request.amount += price * Decimal(count)
    }

    public func deleteProducts() {
        request.productName = []
        request.productPrice = []
        request.productCount = []
        request.amount = 0
    }

    public func generateSignature() {
        request.merchantSignature = generateSignatureString().hmac(algorithm: .MD5, key: secretKey)
    }

    public func addApplePaymentData(json: String) {
        request.applePayString = json
    }

    public func addApplePaymentData(paymentData: Data) {
        if let json = String(data: paymentData, encoding: .utf8) {
            addApplePaymentData(json: json)
        }
    }

    public func sendPaymentRequest(_ handler: @escaping (Result<WFPChargeResponse, Error>) -> Void) throws {
        let encodedData = try JSONEncoder().encode(request)
        try httpClient.sendRequest(url: apiURL,
                                   method: .POST,
                                   body: encodedData
        ) { (result) in
            switch result {
            case let .success(data):
                if let response: WFPChargeResponse = try? JSONDecoder().decode(WFPChargeResponse.self, from: data) {
                    handler(.success(response))
                } else {
                    handler(.failure(WFPError.codableDecodeError))
                }
            case let .failure(error):
                handler(.failure(error))
            }
        }
    }

    private func generateSignatureString() -> String {
        var string: String = ""
        addSignItem(to: &string, request.merchantAccount)
        addSignItem(to: &string, request.merchantDomainName)
        addSignItem(to: &string, request.orderReference)
        addSignItem(to: &string, "\(request.orderDate)")
        addSignItem(to: &string, "\(request.amount)")
        addSignItem(to: &string, request.currency.rawValue)
        request.productName.forEach { (name) in
            addSignItem(to: &string, name)
        }
        request.productCount.forEach { (count) in
            addSignItem(to: &string, "\(count)")
        }
        request.productPrice.forEach { (price) in
            addSignItem(to: &string, "\(price)")
        }
        string.remove(at: string.index(before: string.endIndex))

        return string
    }

    private func addSignItem(to: inout String, _ value: String) {
        to.append(value)
        to.append(";")
    }
}

