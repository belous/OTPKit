//
//  OTPKit.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

public protocol SecretProvidable {
    var secret: String { get }
    var digits: Int { get }
    var movingFactor: MovingFactor { get }
    var hmacAlgorithm: HMACAlgorithm { get }
}

public extension SecretProvidable {

    var currentOTP: String {
        getOTP(at: Date())
    }

    func getOTP(at time: Date) -> String {
        let counter = movingFactor.counterValue(at: time)
        return getOTP(for: counter)
    }

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
