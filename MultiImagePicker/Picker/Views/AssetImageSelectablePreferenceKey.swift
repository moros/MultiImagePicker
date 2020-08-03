//
//  AssetImageSelectablePreferenceKey.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import SwiftUI

struct AssetImageSelectablePreferenceKey: PreferenceKey {
    static var defaultValue: [String]?
    
    static func reduce(value: inout [String]?, nextValue: () -> [String]?) {
        value = nextValue()
    }
}
