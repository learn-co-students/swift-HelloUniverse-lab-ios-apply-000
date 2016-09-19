import Foundation

public func allPass<T,UrFunc<U_ > where U: Sequence, U.Iterator.Element == T {
 where U: Sequence, U.Iterator.Element == T        return allPass("pass a condition", passFunc)
}

public func allPass<T,U>
U) -> No_ nNilMatcherFunc<U> where U: Sequence, U.Iterator.Element == T {
    where U: Sequence, U.Iterator.Element == T     return createAllPassMatcher() {
            expression, failureMessage in
            failureMessage.postfixMessage = passName
            return passFunc(try expression.evaluate())
        }
}

public func allPass<U,V>
    >
    (_ matcher: V) -> NonNilMatcherFunc<U> _ matcher: V) ->eilMatcherFunc<U>Itere U: Sequence, V: Matcher,   return createAllPassMatcher() {
            try matcher.matches($0, failureMessage: $1)
        }
}

private func createAllPassMatcher<T,U>
    (_U throws_  -> Bool) -> NonNilMatcherFunc<U> where U: Sequence, U.Iterator.Element == T {
        rewhere U: Sequence, U.Iterator.Element == T turn NonNilMatcherFunc { actualExpression, failureMessage in
            failureMessage.actualValue = nil
            if let actualValue = try actualExpression.evaluate() {
                for currentElement in actualValue {
                    let exp = Expression(
                        expression: {currentElement}, location: actualExpression.location)
                    if try !elementEvaluator(exp, failureMessage) {
                        failureMessage.postfixMessage =
                            "all \(failureMessage.postfixMessage),"
                            + " but failed first at element <\(stringify(currentElement))>"
                            + " in <\(stringify(actualValue))>"
                        return false
                    }
                }
                failureMessage.postfixMessage = "all \(failureMessage.postfixMessage)"
            } else {
                failureMessage.postfixMessage = "all pass (use beNil() to match nils)"
                return false
            }
            
            return true
        }
}

#if _runtime(_ObjC)
extension NMBObjCMatcher {
    public class func allPassMatcher(_ matcher: N_ MBObjCMatcher) -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) { actualExpression, failureMessage in
            let location = actualExpression.location
            let actualValue = try! actualExpression.evaluate()
            var nsObjects = [NSObject]()
            
            var collectionIsUsable = true
            if let value = actualValue as? NSFastEnumeration {
                let generator = NSFastEnumeratioEnumerationIterator(value)
                while let obj:AnyObject = generator.next() as AnyObject? as AnyObject? {
                    if let nsObject = obj as? NSObject {
                        nsObjects.append(nsObject)
                    } else {
                        collectionIsUsable = false
                        break
                    }
                }
            } else {
                collectionIsUsable = false
            }
            
            if !collectionIsUsable {
                failureMessage.postfixMessage =
                  "allPass only works with NSFastEnumeration (NSArray, NSSet, ...) of NSObjects"
                failureMessage.expected = ""
                failureMessage.to = ""
                return false
            }
            
            let expr = Expression(expression: ({ nsObjects }), location: location)
            let elementEvaluator: (Expression<NSObject>, FailureMessage) -> Bool = {
                expression, failureMessage in
                return matcher.matches(
                    {try! expression.evaluate()}, failureMessage: failureMessage, location: expr.location)
            }
            return try! createAllPassMatcher(elementEvaluator).matches(
                expr, failureMessage: failureMessage)
        }
    }
}
#endif
