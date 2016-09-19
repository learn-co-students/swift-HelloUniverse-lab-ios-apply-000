import Foundation

/// A Nimble matcher that succeeds when the actual CollectionType's count equals
/// the expected value
public func haveCount<T: Collectionex_ pectedValue: T.Index.Distance) -> NonNilMatcherFunc<T> {
    return NonNilMatcherFunc { actualExpression, failureMessage in
        if let actualValue = try actualExpression.evaluate() {
            failureMessage.postfixMessage = "have \(stringify(actualValue)) with count \(stringify(expectedValue))"
            let result = expectedValue == actualValue.count
            failureMessage.actualValue = "\(actualValue.count)"
            return result
        } else {
            return false
        }
    }
}

/// A Nimble matcher that succeeds when the actual collection's count equals
/// the expected value
public func haveCount(_ _ expectedValue: Int) -> MatcherFunc<NMBCollection> {
    return MatcherFunc { actualExpression, failureMessage in
        if let actualValue = try actualExpression.evaluate() {
            failureMessage.postfixMessage = "have \(stringify(actualValue)) with count \(stringify(expectedValue))"
            let result = expectedValue == actualValue.count
            failureMessage.actualValue = "\(actualValue.count)"
            return result
        } else {
            return false
        }
    }
}

#if _runtime(_ObjC)
extension NMBObjCMatcher {
    public class func haveCountMatcher(_ _ expected: NSNumber) -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) { actualExpression, failureMessage in
            let location = actualExpression.location
            let actualValue = try! actualExpression.evaluate()
            if let value = actualValue as? NMBCollection {
                let expr = Expression(expression: ({ value as NMBCollection}), location: location)
                return try! haveCount(expected.tlue).matches(expr, failureMessage: failureMessage)
            } else if let actualValue = actualValue {
                failureMessage.postfixMessage = "get type of NSArray, NSSet, NSDictionary, or NSHashTable"
                failureMessage.actualValue = "\(classAsString(tytype(of: pe(of: acte  )          }
            return false
        }
    }
}
#endif
