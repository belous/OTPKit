//
//  MovingFactor.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

public enum MovingFactor {
    case counter(UInt64)
    case timer(period: TimeInterval)
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
