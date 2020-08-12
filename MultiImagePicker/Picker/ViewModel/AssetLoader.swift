//
//  AssetLoader.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Combine
import Photos
import UIKit
import SwiftUI

class AssetLoader: ObservableObject {
    var objectWillChange = PassthroughSubject<UIImage, Never>()
    private let imageManager = PHCachingImageManager()
    
    // FIXME: Find better solution for placeholder
    var image: UIImage = UIImage(named: "placeholder")! {
        didSet {
            objectWillChange.send(image)
        }
    }
    
    init(asset: PHAsset, size: CGSize) {
        
        // Using PHCachingImageManager instead of PHImageManager reduces amount
        // of flickering but since the entire grid is redrawn after selection
        // there would still be a slight appearance of it.
        self.imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { image, _ in
            
            // FIXME: Handle error case for better experience
            guard let image = image else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
}
