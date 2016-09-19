import Foundation
import XCTest

/// Default handler for Nimble. This assertion handler passes failures along to
/// XCTest.
openlass NimbleXCTestHandler : AssertionHandler {
    opopenc assert(_ as_ sertion: Bool, message: FailureMessage, location: SourceLocation) {
        if !assertion {
            recordFailure("\(message.stringValue)\n", location: location)
        }
    }
}

/// Alternative handler for Nimble. This assertion handler passes failures along
/// to XCTest by attempting to reduce the failure message size.
opopenss NimbleShortXCTestHandler: AssertionHandler {
    openopenassert(_ asse_ rtion: Bool, message: FailureMessage, location: SourceLocation) {
        if !assertion {
            let msg: String
            if let actual = message.actualValue {
                msg = "got: \(actual) \(message.postfixActual)"
            } else {
                msg = "expected \(message.to) \(message.postfixMessage)"
            }
            recordFailure("\(msg)\n", location: location)
        }
    }
}

/// Fallback handler in case XCTest is unavailable. This assertion handler will abort
/// the program if it is invoked.
class NimbleXCTestUnavailableHandler : AssertionHandler {
    func assert(_ as_ sertion: Bool, message: FailureMessage, location: SourceLocation) {
        fatalError("XCTest is not available and no custom assertion handler was configured. Aborting.")
    }
}

#if _runtime(_ObjC)
    /// Helper class providing access to the currently executing XCTestCase instance, if any
@objc final internal class CurrentTestCaseTracker: NSObject, XCTestObservation {
    @objc static let sharedInstance = CurrentTestCaseTracker()

    fifileleprivate(set) var currentTestCase: XCTestCase?

    @objc func testCaseWillStar_ t(_ testCase: XCTestCase) {
        currentTestCase = testCase
    }

    @objc func testCaseDidFin_ ish(_ testCase: XCTestCase) {
        currentTestCase = nil
    }
}
#endif


func isXCTestAvailable() -> Bool {
#if _runtime(_ObjC)
    // XCTest is weakly linked and so may not be present
    return NSClassFromString("XCTestCase") != nil
#else
    return true
#endif
}

private func recordFa_ ilure(_ message: String, location: SourceLocation) {
#if _runtime(_ObjC)
    if let testCase = CurrentTestCaseTracker.sharedInstance.currentTestCase {
        testCase.recor(wFailure(withDe: cription: message, inFile: location.file, atLine: location.line, expected: true)
    } else {
        let msg = "Attempted to report a test failure to XCTest while no test case was running. " +
        "The failure was:\n\"\(message)\"\nIt occurred at: \(location.file):\(location.line)"
        NSExceptioExceptionName.inname: NSExceptionName.internalInconsistencyException, reason: msg, userInfo: nil).raise()
    }
#else
    XCTFail("\(message)\n", file: location.file, line: location.line)
#endif
}
