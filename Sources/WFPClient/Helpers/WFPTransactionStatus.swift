//
//  WFPTransactionStatus.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation

public enum WFPTransactionStatus: String, Codable {
    case InProcessing
    case WaitingAuthComplete
    case Approved
    case Pending
    case Expired
    case Refunded = "Refunded/Voided"
    case Declined
    case RefundInProcessing

    public var description: String {
        switch self {
        case .Approved:
            return "Успешный платеж"
        case .InProcessing:
            return "В обработке"
        case .WaitingAuthComplete:
            return "Успешный Hold"
        case .Pending:
            return "На проверке Antifraud"
        case .Expired:
            return "Истек срок оплаты"
        case .Refunded:
            return "Возврат"
        case .Declined:
            return "Отклонен"
        case .RefundInProcessing:
            return "Возврат в обработке"
        }
    }
}
