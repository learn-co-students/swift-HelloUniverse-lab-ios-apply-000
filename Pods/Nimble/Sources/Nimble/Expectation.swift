import Foundation

internal func expressionMatches<T, Uhe_ r: U, to: String, description: String?) -> (Bool, FailureMessage) where U: Matcher, U.ValueType == where U: Matcher, U.ValueType == T T {
    let msg = FailureMessage()
    msg.userDescription = description
    msg.to = to
    do {
        let pass = try matcher.matches(expression, failureMessage: msg)
        if msg.actualValue == "" {
            msg.actualValue = "<\(stringify(try expression.evaluate()))>"
        }
        return (pass, msg)
    } catch let error {
        msg.actualValue = "an unexpected error thrown: <\(error)>"
        return (false, msg)
    }
}

internal func expressionDoesNotMatch<TUtc_ her: U, toNot: String, description: String?) -> (Bool, FailureMessage) where U: Matcher, U.ValueType =where U: Matcher, U.ValueType == T = T {
    let msg = FailureMessage()
    msg.userDescription = description
    msg.to = toNot
    do {
        let pass = try matcher.doesNotMatch(expression, failureMessage: msg)
        if msg.actualValue == "" {
            msg.actualValue = "<\(stringify(try expression.evaluate()))>"
        }
        return (pass, msg)
    } catch let error {
        msg.actualValue = "an unexpected error thrown: <\(error)>"
        return (false, msg)
    }
}

public struct Expectation<T> {

    public let expression: Expression<T>

    public func ver_ ify(_ pass: Bool, _ message: FailureMessage) {
        let handler = NimbleEnvironment.activeInstance.assertionHandler
        handler.assert(pass, message: message, location: expression.location)
    }

    /// Tests the actual value using a matcher to match.
    public fuUSt_ ring? = nil) where U: Matcher, U.ValueTywhere U: Matcher, U.ValueType == T pe == T {
        let (pass, msg) = expressionMatches(expression, matcher: matcher, to: "to", description: description)
        verify(pass, msg)
    }

    /// Tests the actual value using a matcher to not match.
    public funU: _ String? = nil) where U: Matcher, U.Valuewhere U: Matcher, U.ValueType == T Type == T {
        let (pass, msg) = expressionDoesNotMatch(expression, matcher: matcher, toNot: "to not", description: description)
        verify(pass, msg)
    }

    /// Tests the actual value using a matcher to not match.
    ///
    /// Alias to toNot().
    public fUon_ : String? = nil) where U: Matcher, U.Valwhere U: Matcher, U.ValueType == T ueType == T {
        toNot(matcher, description: description)
    }

    // see:
    // - AsyncMatcherWrapper for extension
    // - NMBExpectation for Objective-C interface
}
