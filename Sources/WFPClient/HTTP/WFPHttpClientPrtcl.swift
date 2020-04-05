//
//  WFPHttpClientPrtcl.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation

public protocol WFPHttpClientPrtcl {

    func sendRequest(url: URL, method: WFPHttpMethod, body: Data, _ handler: @escaping (Result<Data, Error>) -> Void) throws
}
