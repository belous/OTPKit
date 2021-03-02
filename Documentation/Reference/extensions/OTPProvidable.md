**EXTENSION**

# `OTPProvidable`
```swift
public extension OTPProvidable
```

## Methods
### `getOTP(for:)`

```swift
func getOTP(for time: Date) -> String
```

Generates the password for the provided point in time.

- parameter time: The point in time as a `Date` for which the one-time password should be generated.
The time must be after the Unix epoch.

- returns: The generated one-time password.

#### Parameters

| Name | Description |
| ---- | ----------- |
| time | The point in time as a `Date` for which the one-time password should be generated. The time must be after the Unix epoch. |

### `getOTP(for:)`

```swift
func getOTP(for counter: UInt64) -> String
```

Generates the password for the provided counter from UNIX time.

- parameter counter: The counter from UNIX time as a `UInt64` for which the one-time password should be generated.

- returns: The generated one-time password.

#### Parameters

| Name | Description |
| ---- | ----------- |
| counter | The counter from UNIX time as a `UInt64` for which the one-time password should be generated. |