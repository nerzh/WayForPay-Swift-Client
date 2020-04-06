//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation

public enum WFPError: Error, CustomStringConvertible {
    case codableDecodeError

    public var description: String {
        switch self {
        case .codableDecodeError:
            return "Can't decode server response to swift struct"
        }
    }

    public var localizedDescription: String { description }
}
