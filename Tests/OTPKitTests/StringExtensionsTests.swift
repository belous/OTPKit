import XCTest
@testable import OTPKit

final class StringExtensionsTests: XCTestCase {

    func testEmptyPadding() {
        let actual = "abc"
        let result = actual.padded(with: "0", toLength: actual.count)
        let expected = actual
        XCTAssertEqual(result, expected, "the result expected to be \(expected)")
    }

    func testTenZeroPadding() {
        let actual = "abc"
        let amountOfZeros = 10
        let result = actual.padded(with: "0", toLength: actual.count + amountOfZeros)
        let expected = String(repeating: String("0"), count: amountOfZeros) + actual
        XCTAssertEqual(result, expected, "the result expected to be \(expected)")
    }

    static var allTests = [
        ("testEmptyPadding", testEmptyPadding),
        ("testTenZeroPadding", testTenZeroPadding),
    ]
}
