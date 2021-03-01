//
//  MovingFactor.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

/// A `MovingFactor` which is used to produces different one-time passwords over time.
/// Currently implemented only a `Timer` which is a time-based moving factor.
public enum MovingFactor: Equatable, Hashable {

    /// Used for TOTP, with an associated time interval for calculating the time-based moving factor.
    /// The period value remains constant, and is used as a divisor for the number of seconds since the Unix epoch.
    case timer(period: TimeInterval)
}

extension MovingFactor {

    /// Calculates the counter value at the givin period of time. For the TOTP it will be the number of time intervals since the Unix epoch, based on the associated period value.
    ///
    /// - parameter time: The point in time as a `Date`.
    /// The time must be after the Unix epoch.
    ///
    /// - returns: The counter value needed to generate the one-tome password for the given time.
    func counterValue(at time: Date) -> UInt64 {
        switch self {
        case .timer(let period):
            let timeSinceEpoch = time.timeIntervalSince1970
            return UInt64(timeSinceEpoch / period)
        }
    }
}
