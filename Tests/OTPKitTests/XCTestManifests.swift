import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(OTPKitTests.allTests),
        testCase(StringExtensionsTests.allTests),
    ]
}
#endif
