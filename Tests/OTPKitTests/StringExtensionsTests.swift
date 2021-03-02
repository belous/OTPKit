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
        let expected = "0000000000" + actual
        XCTAssertEqual(result, expected, "the result expected to be \(expected)")
    }

    func testBase32() {
        let vectorsForBase32 = [
            ("f", "MY======"),
            ("fo", "MZXQ===="),
            ("foo", "MZXW6==="),
            ("foob", "MZXW6YQ="),
            ("fooba", "MZXW6YTB"),
            ("foobar", "MZXW6YTBOI======"),
        ].map { ($0.data(using: .utf8), $1) }

        for (expect, test) in vectorsForBase32 {
            if let result = test.base32 {
                XCTAssertEqual(result, expect, "base32 decode for \(test)")
            } else {
                XCTFail("base32 decode failed for \(test)")
            }
        }
    }

    static var allTests = [
        ("testEmptyPadding", testEmptyPadding),
        ("testTenZeroPadding", testTenZeroPadding),
        ("testBase32", testBase32),
    ]
}
