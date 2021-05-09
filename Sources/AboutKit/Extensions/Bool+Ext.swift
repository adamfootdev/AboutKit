//
//  Bool+Ext.swift
//  AboutKit
//
//  Created by Adam Foot on 09/05/2021.
//

import Foundation

extension Bool {
    static var isCatalyst: Bool {
        #if targetEnvironment(macCatalyst)
        return true
        #else
        return false
        #endif
    }
}
