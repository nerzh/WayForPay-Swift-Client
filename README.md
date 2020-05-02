# WayForPay-Swift-Client

#### Install with Swift Package Manager

```swift
dependencies: [
    .package(name: "WFPClient", url: "https://github.com/nerzh/WayForPay-Swift-Client.git", from: "0.2.0"),
],
targets: [
    .target(
        name: "YourProject",
        dependencies: [
            .product(name: "WFPClient", package: "WFPClient"),
        ]
    )
]
```


#### Install with Cocoapods

```ruby
pod "WFPClient", '0.2.2'
```

#### Import

```swift
import WFPClient
```

#### Usage

1. Создаем объект request
```swift
let request: WFPChargeRequest = .init(transactionType: .CHARGE,
                                      merchantAccount: "мерчант из кабинета WayForPay",
                                      merchantDomainName: "https://адрес вашего сайта",
                                      orderReference: "id заказа с вашей базы",
                                      orderDate: "дата заказа",
                                      currency: .UAH,
                                      clientFirstName: "Имя клиента",
                                      clientLastName: "Фамилия клиента",
                                      clientCountry: "Ukraine",
                                      clientEmail: "почтовый ящик клиента",
                                      clientPhone: "телефон клиента",
                                      merchantTransactionType: .SALE,
                                      merchantTransactionSecureType: .NON3DS)
```

2. Создаем объект client, среди необязательных параметров есть httpClient, он наследуется от протокола WFPHttpClientPrtcl и требует реализовать всего один метод с помощью которого отправляется запрос на сервер WayForPay, по умолчанию запрос отправляется с помощью URLSession, если хотите можете реализовать свой и передеать его как параметр клиенту
```swift
let client = WFPClient.init(apiURL: URL(string: "https://api.wayforpay.com/api")!,
                            request: request,
                            secretKey: "секретный ключ из кабинета WayForPay для генерации подписи к запросу")
```

3. Так как информация о продукте по протоколу добавляется последовательно в три массива и кейс, в котором ими туда сюда надо будет манипулировать выглядит довольно странно, я сделал два метода:

- собственно добавить продукт к запросу  
```swift
client.addProduct(name: "Test Product", price: 100.50, count: 2)
client.addProduct(name: "Test Product 2", price: 2.50, count: 1)
```
- и на всякий случай метод удаления всех продуктов из запроса
```swift
client.deleteProducts()
```

4. Сумма считается автоматичекси, но если ваша итоговая сумма отличается, можно задать 
```swift
client.request.amount = 199.99
```

5. Генерируем подпись. Подпись надо генерировать после того, как в запросе будут заполнены все поля 
```swift
client.generateSignature()
```

6. Теперь после того, как в методе делегата вы получили PaymentToken, добавляем его к запросу и можно отправлять запрос на оплату в WayForPay и в зависимости от ответа сервера вызывать handler complete 
```swift
func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                        didAuthorizePayment payment: PKPayment,
                                        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
) {
    
    client.addApplePaymentData(paymentData: payment.token.paymentData)
    
    do {
        try client.sendPaymentRequest { (result) in
            switch result {
            case let .success(wfpChargeResponse):
                if wfpChargeResponse.reasonCode == WFPReasonCode.Ok {
                    completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
                } else {
                    completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                }
            case .failure(error):
                completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
            }
        }
    } catch {
        completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
    }
}
```
7. В ответ на sendPaymentRequest от WayForPay вы получите структуру WFPChargeResponse в которой гарантированно будут 

```swift
wfpChargeResponse.reason     /// String
wfpChargeResponse.reasonCode /// WFPReasonCode - enum со всеми кодами ошибок и их описаниями description
```
в зависимости от которых вы сможете определить какой completion status выбирать и определить ваши дальнейшие действия
