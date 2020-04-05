//
//  WFPMerchantTransactionSecureType.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation

public enum WFPMerchantTransactionSecureType: String, Codable {
    case AUTO = "AUTO"
    case ThreeDS = "3DS"
    case NON3DS = "NON3DS"
}
