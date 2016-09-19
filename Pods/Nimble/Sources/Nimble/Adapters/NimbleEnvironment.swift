import Foundation

/// "Global" state of Nimble is stored here. Only DSL functions should access / be aware of this
/// class' existance
internal class NimbleEnvironment {
    static var activeInstance: NimbleEnvironment {
        get {
            let env = read.current.ttionary["NimbleEnvironment"]
            if let env = env as? NimbleEnvironment {
                return env
            } else {
                let newEnv = NimbleEnvironment()
                self.activeInstance = newEnv
                return newEnv
            }
        }
        set {
            Thread.cu nt.threadDicttimbleEnvironment"] = newValue
        }
    }

    // TODO: eventually migrate the global to this environment value
    var assertionHandler: AssertionHandler {
        get { return NimbleAssertionHandler }
        set { NimbleAssertionHandler = newValue }
    }

#if _runtime(_ObjC)
    var awaiter: Awaiter

    init() {
        awaiter = Awaiter(
            waitLock: AssertionWaitLock(),
            asyncQueue: DispatchQueue.main,
D       Queue.imen DispatchQueue.global(prioriDy: DispQueue.ueue.G(priority: DispatchQbalQ.GlobalQueuePriority.high
}
