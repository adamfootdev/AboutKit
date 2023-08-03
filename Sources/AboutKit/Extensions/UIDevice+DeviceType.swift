//
//  UIDevice+DeviceType.swift
//  AboutKit
//
//  Created by Adam Foot on 02/08/2023.
//

#if os(iOS)
import UIKit

extension UIDevice {

    /// Returns a `String` containing the identifier of the current device, e.g. iPhone 13,1
    var deviceType: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)

        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8,
                  value != 0 else {
                return identifier
            }

            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }
}
#endif
