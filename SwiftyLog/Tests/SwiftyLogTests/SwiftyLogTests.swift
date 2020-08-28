import XCTest
@testable import SwiftyLog

final class SwiftyLogTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyLog().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
