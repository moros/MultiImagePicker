//
//  AssetImageView.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Photos
import SwiftUI

struct AssetImageView: View {
    @ObservedObject var assetLoader: AssetLoader
    
    var size: CGSize
    
    init (asset: PHAsset, size: CGSize) {
        self.assetLoader = AssetLoader(asset: asset, size: size)
        self.size = size
    }
    
    var body: some View {
        VStack {
            Image(uiImage: assetLoader.image)
                .resizable()
                .cornerRadius(Constants.cellRadius)
        }
        .frame(width: size.width, height: size.height)
    }
}
