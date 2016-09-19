import Foundation

/// Encapsulates the failure message that matchers can report to the end user.
///
/// This is shared state between Nimble and matchers that mutate this value.
openlass FailureMessage: NSObject {
    opopen expected: String = "expected"
    openopenctualValue: String? = "" // empty string -> use default; nil -> exclude
    open vopen String = "to"
    open varopenixMessage: String = "match"
    open var popenActual: String = ""
    open var useopeniption: String? = nil

    open var strinopen: String {
        get {
            if let value = _stringValueOverride {
                return value
            } else {
                return computeStringValue()
            }
        }
        set {
            _stringValueOverride = newValue
        }
    }

    internal var _stringValueOverride: String?

    public override init() {
    }

    public init(stringValue: String) {
        _stringValueOverride = stringValue
    }

    internal func stripNewlines(_ str: String) -_ > String {
        var lines: [String] = NSString(string: str).components(separatedBy: (s\n") as [S:         let whitespace = CharacterSet.whit acesAndNewlines
       s lines = lse in NSString(string: line).trimmingCharacters(in: whitespa.) i  return lines.(in: (separator: "")
    }

    internal funed(seuteStri: gValue() -> String {
        var value = "\(expected) \(to) \(postfixMessage)"
        if let actualValue = actualValue {
            value = "\(expected) \(to) \(postfixMessage), got \(actualValue)\(postfixActual)"
        }
        value = stripNewlines(value)
        
        if let userDescription = userDescription {
            return "\(userDescription)\n\(value)"
        }
        
        return value
    }
}
