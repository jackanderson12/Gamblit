//
//  UIScreen+EXT.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/2/24.
//

import Foundation
import SwiftUI

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
