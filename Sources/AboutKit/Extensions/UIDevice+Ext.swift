//
//  UIDevice+Ext.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import UIKit

extension UIDevice {
    /// Returns a string containing the identifier of the current device e.g. iPhone 13,1
    var deviceType: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        
        if let model = String(validatingUTF8: modelCode!) {
            return model
        }
        
        return "Unknown Device"
    }
}
