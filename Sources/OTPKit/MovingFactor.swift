//
//  MovingFactor.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

public enum MovingFactor: Codable, Equatable, Hashable {
    case counter(UInt64)
    case timer(period: TimeInterval)
}

public extension MovingFactor {

    private enum CodingKeys: String, CodingKey {
        case counter
        case timer
    }

    enum MovingFactorCodingError: Error {
        case decoding(String)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(UInt64.self, forKey: .counter) {
            self = .counter(value)
            return
        }
        if let value = try? values.decode(TimeInterval.self, forKey: .timer) {
            self = .timer(period: value)
            return
        }
        throw MovingFactorCodingError.decoding("Whoops! \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .counter(let value):
            try container.encode(value, forKey: .counter)
        case .timer(let period):
            try container.encode(period, forKey: .timer)
        }
    }
}

extension MovingFactor {
    func counterValue(at time: Date) -> UInt64 {
        switch self {
        case .counter(let counter):
            return counter
        case .timer(let period):
            let timeSinceEpoch = time.timeIntervalSince1970
            return UInt64(timeSinceEpoch / period)
        }
    }
}
