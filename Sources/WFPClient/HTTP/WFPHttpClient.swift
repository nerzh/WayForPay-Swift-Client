//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation
import SwiftExtensionsPack

open class WFPHttpClient: WFPHttpClientPrtcl {

    public init() {}
    
    public func sendRequest(url: URL,
                            method: WFPHttpMethod,
                            body: Data,
                            _ handler: @escaping (Result<Data, Error>) -> Void
    ) throws {
        try Net.sendRequest(url: url.absoluteString,
                            method: method.rawValue,
                            body: body
        ) { (data, response, error) in
            if let data = data {
                handler(.success(data))
            } else if let error = error {
                handler(.failure(error))
            }
        }
    }
}
