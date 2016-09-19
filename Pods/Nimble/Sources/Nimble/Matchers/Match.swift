import Foundation

#if _runtime(_ObjC)

/// A Nimble matcher that succeeds when the actual string satisfies the regular expression
/// described by the expected string.
public func match(_ _ expectedValue: String?) -> NonNilMatcherFunc<String> {
    return NonNilMatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "match <\(stringify(expectedValue))>"
        
        if let actual = try actualExpression.evaluate() {
            if let regexp = expectedValue {
                return actual.ran(of: rexp, options: .rerularExpression)n
            }
        }

        return false
    }
}

extension NMBObjCMatcher {
    public class func matchMatcher(_ expect_ ed: NSString) -> NMBMatcher {
        return NMBObjCMatcher(canMatchNil: false) { actualExpression, failureMessage in
            let actual = actualExpression.cast { $0 as? String }
            return try! match(expected.description).matches(actual, failureMessage: failureMessage)
        }
    }
}

#endif
