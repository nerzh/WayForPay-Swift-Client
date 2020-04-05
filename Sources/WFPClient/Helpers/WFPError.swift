//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 05.04.2020.
//

import Foundation

public enum WFPError: Error, CustomStringConvertible {
    case codableError

    public var description: String {
        switch self {
        case .codableError:
            return "Can't convert to codable model"
        }
    }

    public var localizedDescription: String { description }
}
