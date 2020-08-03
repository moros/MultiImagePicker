//
//  AssetImageSelectableView.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Photos
import SwiftUI

struct AssetImageSelectableView: View {
    @Binding var selectedIds: [String]
    
    var asset: PHAsset
    var size: CGSize
    
    // Width related font size between 20 and 35
    private var fontSize: CGFloat {
        min(max(CGFloat(size.width / 8), Constants.checkmarkMinFontSize), Constants.checkmarkMaxFontSize)
    }
    
    private var offset: CGFloat {
        fontSize / 3
    }
    
    init (asset: PHAsset, size: CGSize, selectedIds: Binding<[String]>) {
        self.size = size
        self.asset = asset
        self._selectedIds = selectedIds
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            AssetImageView(asset: asset, size: size)
            if self.selectedIds.contains(self.asset.localIdentifier) {
                Image(systemName: Constants.checkmarkIcon)
                    .font(.system(size: fontSize))
                    .frame(height: fontSize)
                    .foregroundColor(.blue)
                    .background(Color.white.mask(Circle()))
                    .offset(x: offset, y: offset)
            }
        }.onTapGesture {
            if let firstIndex = self.selectedIds.firstIndex(of: self.asset.localIdentifier) {
                self.selectedIds.remove(at: firstIndex)
            }
            else {
                self.selectedIds.append(self.asset.localIdentifier)
            }
        }
        .preference(key: AssetImageSelectablePreferenceKey.self, value: selectedIds)
        .frame(width: size.width, height: size.height)
    }
}
