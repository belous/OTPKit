//
//  OTPKit.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

/// A `OTPProvidable` protocol which specifies the minimum set of parameters needed to generate a One-Time Password
public protocol OTPProvidable {

    /// The secret key shared between client and server.
    var secret: String { get }

    /// The number od digits in one-time password.
    var digits: Int { get }

    /// The moving factor, timer- or counter-based.
    var movingFactor: MovingFactor { get }

    /// The hash function used to generate the password.
    var hmacAlgorithm: HMACAlgorithm { get }
}

/// An extension to `OTPProvidable` which defines functions for generating One-Time Password
public extension OTPProvidable {

    // MARK: - One-Time Password Generation

    /// Generates the password for the provided point in time.
    ///
    /// - parameter time: The point in time as a `Date` for which the one-time password should be generated.
    /// The time must be after the Unix epoch.
    ///
    /// - returns: The generated one-time password.
    func getOTP(for time: Date) -> String {
        let counter = movingFactor.counterValue(at: time)
        return getOTP(for: counter)
    }

    /// Generates the password for the provided counter from UNIX time.
    ///
    /// - parameter counter: The counter from UNIX time as a `UInt64` for which the one-time password should be generated.
    ///
    /// - returns: The generated one-time password.
    func getOTP(for counter: UInt64) -> String {
        var bigEndianCounter = counter.bigEndian
        let counterData = Data(bytes: &bigEndianCounter, count: MemoryLayout<UInt64>.size)

        guard let base32Secret = secret.base32 else { return "" }

        let hash = HMAC(algorithm: hmacAlgorithm, key: base32Secret, data: counterData)

        var truncatedHash = hash.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> UInt32 in
            let unsafeBufferPointer = bytes.bindMemory(to: UInt8.self)
            guard let ptr = unsafeBufferPointer.baseAddress else {
                return 0
            }
            let offset = ptr[hash.count - 1] & 0x0f
            let truncatedHashPtr = ptr + Int(offset)
            return truncatedHashPtr.withMemoryRebound(to: UInt32.self, capacity: 1) { $0.pointee }
        }

        truncatedHash = UInt32(bigEndian: truncatedHash)
        truncatedHash &= 0x7fffffff
        truncatedHash = truncatedHash % UInt32(pow(10, Float(digits)))

        return String(truncatedHash).padded(with: "0", toLength: digits)
    }
}
