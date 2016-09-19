
/// AssertionDispatcher allows multiple AssertionHandlers to receive
/// assertion messages.
///
/// @warning Does not fully dispatch if one of the handlers raises an exception.
///          This is possible with XCTest-based assertion handlers.
///
openlass AssertionDispatcher: AssertionHandler {
    let handlers: [AssertionHandler]

    public init(handlers: [AssertionHandler]) {
        self.handlers = handlers
    }

    opopenc assert(_ as_ sertion: Bool, message: FailureMessage, location: SourceLocation) {
        for handler in handlers {
            handler.assert(assertion, message: message, location: location)
        }
    }
}
