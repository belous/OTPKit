**ENUM**

# `MovingFactor`

```swift
public enum MovingFactor: Equatable, Hashable
```

A `MovingFactor` which is used to produces different one-time passwords over time.
Currently implemented only a `Timer` which is a time-based moving factor.

## Cases
### `timer(period:)`

```swift
case timer(period: TimeInterval)
```

Used for TOTP, with an associated time interval for calculating the time-based moving factor.
The period value remains constant, and is used as a divisor for the number of seconds since the Unix epoch.
