# OTPKit

A small library written in Swift which can generate time-based one-time passwords.

[![Swift](https://github.com/belous/OTPKit/actions/workflows/swift.yml/badge.svg)](https://github.com/belous/OTPKit/actions/workflows/swift.yml)
[![codecov](https://codecov.io/gh/belous/OTPKit/branch/main/graph/badge.svg?token=21FV5GU1S7)](https://codecov.io/gh/belous/OTPKit)
[![CodeFactor](https://www.codefactor.io/repository/github/belous/otpkit/badge)](https://www.codefactor.io/repository/github/belous/otpkit)

## Installation

- In  `Package.swift` add the following:

```swift
dependencies: [
    .package(url: "https://github.com/belous/OTPKit.git", from: "0.2.0"),
],
targets: [
    .target(
        name: "MainApp",
        dependencies: ["OTPKit"]
    )
    …
]
```

## Usage

Create a struct or class and confirm it to the `OTPProvidable` protocol:

```swift
public struct Secret: Codable, Equatable, Hashable {
    public let secret: String
    public let digits: Int
    public let movingFactor: MovingFactor
    public let hmacAlgorithm: HMACAlgorithm

    public init(secret: String,
                digits: Int = 6,
                movingFactor: MovingFactor = .timer(period: 30),
                hmacAlgorithm: HMACAlgorithm = .sha1) {
        self.secret = secret
        self.digits = digits
        self.movingFactor = movingFactor
        self.hmacAlgorithm = hmacAlgorithm
    }
}

extension Secret: OTPProvidable {}
```

To generate the current password you can call func `getOTP(for: date)` on instance of your's `OTPProvidable`:

```swift
let secret = Secret(secret: "AABCDEFABCDEFABC")
let currentPassword = secret.getOTP(for: Date())
```

## License

This project is made available under the terms of the [MIT License](http://opensource.org/licenses/MIT).
