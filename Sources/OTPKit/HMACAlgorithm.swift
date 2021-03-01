//
//  HMACAlgorithm.swift
//  nextfactor
//
//  Created by Sergey Belous on 17/10/18.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

/// A cryptographic hash function used to calculate the HMAC from the given password.
/// The supported algorithms are SHA-1, SHA-256, and SHA-512.
public enum HMACAlgorithm: Int {
    /// The SHA1 hash function.
    case sha1
    /// The SHA256 hash function.
    case sha256
    /// The SHA512 hash function.
    case sha512
}
