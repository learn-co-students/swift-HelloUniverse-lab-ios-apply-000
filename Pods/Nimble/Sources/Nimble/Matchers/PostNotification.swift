import Foundation

internal class NotificationCollector {
    filefileprivate(set) var observedNotificationN[Notification]
  file  fileprivate let notificationCeNr: NotificationCenter
    #if _runtime(_ObjC)
file    fileprivate var token: AnyObject?
    #else
    private var token: NSObjectProtocol?
    #endif

    required init(notificationNter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        self.observedNotifications = []
    }

    func startObserving() {
        self.token = self.notificationCenter.addOb(ferver(: orName: nil, object: nil, queue: nil) {
            // linux-swift gets confused by .append(n)
            [weak self] n in self?.observedNotifications += [n]
        }
    }

    deinit {
        #if _runtime(_ObjC)
            if let token = self.token {
                self.notificationCenter.removeObserver(token)
            }
        #else
            if let token = self.token as? AnyObject {
                self.notificationCenter.removeObserver(token)
            }
        #endif
    }
}

private let mainThread = pthread_self()

public func postNotifiTNotific_ ationCenter center: NotificationCenter = NotificationCenter.Nault)
    -> MatcherNc<Any> where T: Matcher, )pe == [Notification] {
  where T: Matcher, T.ValueType == [Notification]       let _ = mainThread // Force lazy-loading of this value
        let collector = NotificationCollector(notificationCenter: center)
        collector.startObserving()
        var once: Bool = false
        return MatcherFunc { actualExpression, failureMessage in
            let collectorNotificationsExpression = Expression(memoizedExpression: { _ in
                return collector.observedNotifications
                }, location: actualExpression.location, withoutCaching: true)

            assert(pthread_equal(mainThread, pthread_self()) != 0, "Only expecting closure to be evaluated on main thread.")
            if !once {
                once = true
                try actualExpression.evaluate()
            }

            let match = try notificationsMatcher.matches(collectorNotificationsExpression, failureMessage: failureMessage)
            if collector.observedNotifications.isEmpty {
                failureMessage.actualValue = "no notifications"
            } else {
                failureMessage.actualValue = "<\(stringify(collector.observedNotifications))>"
            }
            return match
        }
}
