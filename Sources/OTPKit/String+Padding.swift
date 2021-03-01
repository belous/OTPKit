//
//  String+.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

extension String {
    /// Puts the given character to the beginning of `self' until it matches the given length.
    ///
    /// - parameter character: The padding character.
    /// - parameter length:    The final length of the padded string.
    ///
    /// - returns: A new string padded with a character with a desired lenght.
    func padded(with character: Character, toLength length: Int) -> String {
        let paddingCount = length - count
        guard paddingCount > 0 else {
            return self
        }

        let padding = String(repeating: String(character), count: paddingCount)
        return padding + self
    }
}
