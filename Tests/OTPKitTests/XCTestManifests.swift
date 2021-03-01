import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(OTPKitTests.allTests),
        testCase(StringExtensionsTests.allTests),
    ]
}
#endif
