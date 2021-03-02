**ENUM**

# `HMACAlgorithm`

```swift
public enum HMACAlgorithm: Int, Equatable, Hashable
```

A cryptographic hash function used to calculate the HMAC from the given password.
The supported algorithms are SHA-1, SHA-256, and SHA-512.

## Cases
### `sha1`

```swift
case sha1
```

The SHA1 hash function.

### `sha256`

```swift
case sha256
```

The SHA256 hash function.

### `sha512`

```swift
case sha512
```

The SHA512 hash function.
