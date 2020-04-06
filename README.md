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


Вот и всё :)








## Инструкция - как настроить оплату с помощью Apple Pay и WayForPay-Swift-Client через платежный шлюз WayForPay напрямую с iOS. 

1. Вам необходимо зарегистрироваться на сайте https://wayforpay.com

2. Вам необходимо добавить магазин и пройти его активацию.

3. После того, как ваш магазин будет активирован надо запросить по почте support@wayforpay.com запрос на получение сертификата.

4. После того как вам на почту прийдет файл запроса для того, чтобы создать сертификат вам в начале потребуется создать MerchantID indentifier:

![apple_pay_way_for_pay_1](https://user-images.githubusercontent.com/10519803/78548959-47554c80-780a-11ea-97ce-65738e170c1c.png)

![apple_pay_way_for_pay_2](https://user-images.githubusercontent.com/10519803/78549002-589e5900-780a-11ea-838b-36430c745a37.png)

- 4.1 Description может быть любой, Identifier поговаривают, что должен быть как домен сайта закрепленного за приложением, например такой:
если ваш домен https://example.com.ua, то мерчант merchant.ua.com.example 
![apple_pay_way_for_pay_3](https://user-images.githubusercontent.com/10519803/78549040-648a1b00-780a-11ea-955c-b9308e2a4c7d.png)

- 4.2 Далее переходите снова на страницу Identifiers, справа выбераете список Merchant IDs и тыкаете в ваш только созданный MerchantID
![apple_pay_way_for_pay_3_1](https://user-images.githubusercontent.com/10519803/78549130-897e8e00-780a-11ea-9c95-e23570f965bf.png)

- 4.3 Там вы уже сможете создать сертификат с помощью файла запроса, который вам прислала поддержка WayForPay ранее на почту
![apple_pay_way_for_pay_4](https://user-images.githubusercontent.com/10519803/78549081-74096400-780a-11ea-8277-4e73d15996f1.png)
