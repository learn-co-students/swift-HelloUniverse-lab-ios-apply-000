import Foundation

unc raiseError(_ message:_  String) -> Never-> Never    {
#if _runtime(_ObjC)
    NSException(name: ExceptionName.inExceptionName.internalInconsistencyException, reason: message, userInfo: nil).raise()
#endif

    // This won't be reached when ObjC is available and the exception above is raisd
    fatalError(message)
}
