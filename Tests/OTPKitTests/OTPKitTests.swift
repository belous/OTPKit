import XCTest
@testable import OTPKit

final class OTPKitTests: XCTestCase {
    func testNonEmptyOTP() {
        let secret = Secret(secret: "AABCDEFABCDEFABC")
        let password = secret.getOTP(for: Date())
        XCTAssertTrue(!password.isEmpty, "One-time password shouldn't be emtpy")
    }

    func testExpectedOTPForTheSpecificDate() {
        let secret = Secret(secret: "AABCDEFABCDEFABC")
        let date = Date(timeIntervalSince1970: 0)
        let password = secret.getOTP(for: date)
        let expected = "964849"
        XCTAssertEqual(password, expected, "One-time password for the specific date should be \(expected)")
    }

    func testExpectedOTPForTheSpecificCounter() {
        let secret = Secret(secret: "AABCDEFABCDEFABC")
        let password = secret.getOTP(for: 0)
        let expected = "964849"
        XCTAssertEqual(password, expected, "One-time password for the specific date should be \(expected)")
    }

    func testExpectedOTPForSHA256() {
        let secret = Secret(secret: "AABCDEFABCDEFABC", hmacAlgorithm: .sha256)
        let password = secret.getOTP(for: Date(timeIntervalSince1970: 1614674826.597723))
        let expected = "413331"
        XCTAssertEqual(password, expected, "One-time password for the specific date should be \(expected)")
    }

    func testExpectedOTPForSHA512() {
        let secret = Secret(secret: "AABCDEFABCDEFABC", hmacAlgorithm: .sha512)
        let password = secret.getOTP(for: Date(timeIntervalSince1970: 1614674904.56199))
        let expected = "755339"
        XCTAssertEqual(password, expected, "One-time password for the specific date should be \(expected)")
    }

    func testEmptySecret() {
        let expected = ""
        let secret = Secret(secret: expected)
        let password = secret.getOTP(for: 0)
        XCTAssertEqual(password, expected, "One-time password for the specific date should be \(expected)")
    }

    static var allTests = [
        ("testNonEmptyOTP", testNonEmptyOTP),
        ("testExpectedOTPForTheSpecificDate", testExpectedOTPForTheSpecificDate),
        ("testExpectedOTPForTheSpecificCounter", testExpectedOTPForTheSpecificCounter),
        ("testExpectedOTPForSHA256", testExpectedOTPForSHA256),
        ("testExpectedOTPForSHA512", testExpectedOTPForSHA512),
        ("testEmptySecret", testEmptySecret),
    ]
}
