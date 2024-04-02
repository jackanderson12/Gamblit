//
//  UIWindow+EXT.swift
//  Gamblit
//
//  Created by Jack Anderson on 4/2/24.
//

import Foundation
import SwiftUI

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
