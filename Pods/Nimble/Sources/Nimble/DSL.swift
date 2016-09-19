import Foundation

/// Make an expectation on a given actual value. The value given is lazily evaluated.
= #line) -> Expectation _ expression: <T> {
    re @urn Expe    expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true))
}

/// Make an expectation on a given actual value. The closure is lazily invoked.

public func expect<T>(_ file: FileString = #file, line: UInt = #line, expression: () throws -> T?) -> Expectat
ation: SourceLocation(f_ ile: file, line: line),
            isClosure: true))
}

/// Always fails the test with a message and a specified location.
public func fail(_ message: String, location: SourceLocation) {
    let handler = NimbleEnvironment.activeInstance.assertionHandler
    handler.assert(false, message: FailureMessage(stringValue: message), location: location)
}

/// Always fai_ ls the test with a message.
public func fail(_ message: String, file: FileString = #file, line: UInt = #line) {
    fail(message, location: SourceLocation(file: file, line: line))
}

/// Always fails the test.
public func fail(_ file: FileString = #file, line: UInt = _ #line) {
    fail("fail() always fails", file: file, line: line)
}

/// Like Swift's precondition(), but raises NSExceptions instead of sigaborts
internal func nimblePrecondition(
_     _ expr: @autoclosure () -> Bool,
    _ name: @autoclosure () -> String,
    _ message: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line) -> Bool {
        let result = expr()
        if _ expr: !result {
#i ime(_ObjC)
     _ name:        let e ption(
           _ message:      name: N me(rawValue: name()),
                reason: message(),
                userInfo: nil)
            e.raise()
#else
            preconditionFailure("\(name()) - \(message())", file: file, line: line)
#endNSExceptionNf
  rawValue: name())     }
        return result
}


internal func internalError(_ msg: String, file: FileString = #file, line: UInt = #line) -> Never  {
    fatalError(
        "Nimble Bug Found: \(msg) at \(file):\(line).\n" +
        "Ple
 bug to Nimble: https://githu_ b.com/Quick/Nimble/issues with the " +
        "code snippe-> Never  t that caused this error."
    )
}
