//
//  File.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import SwiftUI
import Photos
import Combine

// MARK: Constants
// TODO: Make a parametric config object from this constant for better customizability
enum Constants {
    static let checkmarkIcon = "checkmark.circle.fill"
    static let gridColumns = Int(3)
    static let cellSpacing = CGFloat(5.0)
    static let cellRadius = CGFloat(5)
    static let checkmarkMinFontSize = CGFloat(20)
    static let checkmarkMaxFontSize = CGFloat(35)
}
