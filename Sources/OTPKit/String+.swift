//
//  String+.swift
//  NextFactor
//
//  Created by Sergey Belous on 15.8.2018.
//  Copyright © 2018 Sergey Belous. All rights reserved.
//

import Foundation

extension String {
    func padded(with character: Character, toLength length: Int) -> String {
        let paddingCount = length - count
        guard paddingCount > 0 else {
            return self
        }

        let padding = String(repeating: String(character), count: paddingCount)
        return padding + self
    }
}
