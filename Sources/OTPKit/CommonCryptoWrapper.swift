//
//  CommonCryptoWrapper.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation
import CommonCrypto

private extension HMACAlgorithm {
    /// The `hashInfo` is a computed variable which type is a tuple of CommonCrypto hash function and corresponding digest length.
    var hashInfo: (hmacAlg: CCHmacAlgorithm, digestLength: Int) {
        switch self {
        case .sha1:
            return (CCHmacAlgorithm(kCCHmacAlgSHA1), Int(CC_SHA1_DIGEST_LENGTH))
        case .sha256:
            return (CCHmacAlgorithm(kCCHmacAlgSHA256), Int(CC_SHA256_DIGEST_LENGTH))
        case .sha512:
            return (CCHmacAlgorithm(kCCHmacAlgSHA512), Int(CC_SHA512_DIGEST_LENGTH))
        }
    }
}

/// Swift-wrapper for the CommonCrypto CCHmac-function
///
/// - parameter algorithm: `HMACAlgorithm` algorithm to perform.
/// - parameter key: Raw key bytes.
/// - parameter data: Data to process.
///
/// - returns: The resulted hash value for the given parameters.
func HMAC(algorithm: HMACAlgorithm, key: Data, data: Data) -> Data {
    let (hmacAlg, digestLength) = algorithm.hashInfo

    let macOut = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
    defer {
        macOut.deallocate()
    }

    data.withUnsafeBytes { (dataBytes: UnsafeRawBufferPointer) -> Void in
        key.withUnsafeBytes { (keyBytes: UnsafeRawBufferPointer) -> Void in
            CCHmac(hmacAlg, keyBytes.baseAddress, keyBytes.count, dataBytes.baseAddress, dataBytes.count, macOut)
        }
    }

    return Data(bytes: macOut, count: digestLength)
}
