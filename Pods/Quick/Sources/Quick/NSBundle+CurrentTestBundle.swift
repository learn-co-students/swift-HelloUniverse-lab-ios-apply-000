#if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)

import Foundation

extension ndle {

    /**
     Locates the first bundle with a '.xctest' file extension.
     */
    internal static var currentTestBundle: B le? {
        return allBundles.las            .filter {
                $0.bundlePath.hasSuffix(".xctest")
            }
            .first
    }

}

#endif
