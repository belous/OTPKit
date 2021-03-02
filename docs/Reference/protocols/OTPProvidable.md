**PROTOCOL**

# `OTPProvidable`

```swift
public protocol OTPProvidable
```

A `OTPProvidable` protocol which specifies the minimum set of parameters needed to generate a One-Time Password

## Properties
### `secret`

```swift
var secret: String
```

The secret key shared between client and server.

### `digits`

```swift
var digits: Int
```

The number od digits in one-time password.

### `movingFactor`

```swift
var movingFactor: MovingFactor
```

The moving factor, timer- or counter-based.

### `hmacAlgorithm`

```swift
var hmacAlgorithm: HMACAlgorithm
```

The hash function used to generate the password.
