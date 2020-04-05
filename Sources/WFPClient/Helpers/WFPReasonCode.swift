//
//  WFPReasonCode.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation

public enum WFPReasonCode: Int, Codable {
    case Ок                                   = 1100
    case DeclinedToCardIssuer                 = 1101
    case BadCVV2                              = 1102
    case ExpiredCard                          = 1103
    case InsufficientFunds                    = 1104
    case InvalidCard                          = 1105
    case ExceedWithdrawalFrequency            = 1106
    case ThreeDsFail                          = 1108
    case FormatError                          = 1109
    case invalidCurrency                      = 1110
    case DuplicateOrderID                     = 1112
    case InvalidSignature                     = 1113
    case Fraud                                = 1114
    case ParameterIsMissing                   = 1115
    case TokenNotFound                        = 1116
    case APINotAllowed                        = 1117
    case MerchantRestriction                  = 1118
    case AuthenticationUnavailable            = 1120
    case AccountNotFound                      = 1121
    case GateDeclined                         = 1122
    case RefundNotAllowed                     = 1123
    case CardholderSessionExpired             = 1124
    case CardholderCanceledTheRequest         = 1125
    case IllegalOrderState                    = 1126
    case OrderNotFound                        = 1127
    case RefundLimitExcended                  = 1128
    case ScriptError                          = 1129
    case InvalidAmount                        = 1130
    case TransactionInProcessing              = 1131
    case TransactionIsDelayed                 = 1132
    case InvalidCommission                    = 1133
    case TransactionIsPending                 = 1134
    case CardLimitsFailed                     = 1135
    case MerchantBalanceIsVerySmall           = 1136
    case InvalidConfirmationAmount            = 1137
    case RefundInProcessing                   = 1138
    case ExternalDeclineWhileCredit           = 1139
    case ExceedWithdrawalFrequencyWhileCredit = 1140
    case PartialVoidIsNotSupported            = 1141
    case RefusedACredit                       = 1142
    case InvalidPhoneNumber                   = 1143
    case TransactionIsAwaitingDelivery        = 1144
    case TransactionIsAwaitingCreditDecision  = 1145
    case RestrictedCard                       = 1146
    case ClientIsNotFound                     = 1147
    case ClientIsNotLinked                    = 1148
    case ClientIsLocked                       = 1149
    case Wait3dsData                          = 5100

    public var description: String {
        switch self {
        case .Ок:
            return "Операция выполнена без ошибок"
        case .DeclinedToCardIssuer:
            return "Отказ Банка эмитента проводить операцию"
        case .BadCVV2:
            return "Неверный CVV код"
        case .ExpiredCard:
            return "Карта просрочена или неверно указан срок действия"
        case .InsufficientFunds:
            return "Недостаточно средств"
        case .InvalidCard:
            return "Введен неверный номер карты, либо карта в недопустимом состоянии."
        case .ExceedWithdrawalFrequency:
            return "Превышен лимит операций по карте - возможно карта не открыта для оплаты в интернет"
        case .ThreeDsFail:
            return "Невозможно выполнить 3DS транзакцию, либо неверный код подтверждения 3DS"
        case .FormatError:
            return "Ошибка на стороне мерчанта — неверно сформирована транзакция"
        case .invalidCurrency:
            return "Ошибка на стороне мерчанта- неверная валюта"
        case .DuplicateOrderID:
            return "Дублирующий orderid"
        case .InvalidSignature:
            return "Не правильная подпись мерчанта"
        case .Fraud:
            return "Фродовая транзакция согласно антифрод фильтров"
        case .ParameterIsMissing:
            return "Один или несколько обязательных параметров не переданы"
        case .TokenNotFound:
            return "Попытка списания с карты клиента по токену неуспешна - используется неверное значение"
        case .APINotAllowed:
            return "Данный API не разрешен к использованию для мерчанта"
        case .MerchantRestriction:
            return "Превышен лимит Магазина или транзакции запрещены Магазину"
        case .AuthenticationUnavailable:
            return "3-D Secure авторизация недоступна"
        case .AccountNotFound:
            return "Аккаунт не найден"
        case .GateDeclined:
            return "Отказ шлюза в выполнении операции"
        case .RefundNotAllowed:
            return "Возврат не может быть выполнен"
        case .CardholderSessionExpired:
            return "Сессия пользователя истекла"
        case .CardholderCanceledTheRequest:
            return "Транзакция отменена пользователем"
        case .IllegalOrderState:
            return "Попытка выполнения недопустимой операции для текущего состояния платежа"
        case .OrderNotFound:
            return "Транзакция не найдена"
        case .RefundLimitExcended:
            return "Превышено допустимое число попыток произвести возврат (Refund)"
        case .ScriptError:
            return "Ошибка сценария"
        case .InvalidAmount:
            return "Неправильная сумма"
        case .TransactionInProcessing:
            return "Заказ обрабатывается. Заказ все еще находится в процессе обработки платежным шлюзом"
        case .TransactionIsDelayed:
            return "Клиент решил отложить оплату, ему на почту отправлена ссылка для завершения платежа"
        case .InvalidCommission:
            return "Неверная комиссия"
        case .TransactionIsPending:
            return "Транзакция на проверке Antifraud"
        case .CardLimitsFailed:
            return "Превышен лимит по карте"
        case .MerchantBalanceIsVerySmall:
            return "Недостаточно средств на балансе мерчанта"
        case .InvalidConfirmationAmount:
            return "Неправильная сумма подтверждения верификации карты"
        case .RefundInProcessing:
            return "Запрос на возврат принят и будет проведен как только на балансе магазина будет достаточно денег для его проведения"
        case .ExternalDeclineWhileCredit:
            return "Отказ в зачислении средств на карту получателя"
        case .ExceedWithdrawalFrequencyWhileCredit:
            return "Превышен лимит при зачислении средств на карту получателя"
        case .PartialVoidIsNotSupported:
            return "Частичная отмена холда не доступна"
        case .RefusedACredit:
            return "Отказано в кредите"
        case .InvalidPhoneNumber:
            return "Неверный номер телефона"
        case .TransactionIsAwaitingDelivery:
            return ""
        case .TransactionIsAwaitingCreditDecision:
            return "Ожидание решения о предоставлении кредита"
        case .RestrictedCard:
            return "Карта заблокирована в Банке"
        case .ClientIsNotFound:
            return "Клиент не найден"
        case .ClientIsNotLinked:
            return "Клиент найден, но не привязан к текущему мерчанту"
        case .ClientIsLocked:
            return "Клиент временно заблокирован"
        case .Wait3dsData:
            return "Ожидание 3d secure верификации"
        }
    }
}
