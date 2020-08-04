//
//  AssetLoader.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Combine
import Photos
import UIKit

class AssetLoader: ObservableObject {
    var objectWillChange = PassthroughSubject<UIImage, Never>()
    
    // FIXME: Find better solution for placeholder
    var image: UIImage = UIImage(named: "placeholder")! {
        didSet {
            objectWillChange.send(image)
        }
    }
    
    init(asset: PHAsset, size: CGSize) {
        PHImageManager.default()
            .requestImage(
                for: asset,
                targetSize: size,
                contentMode: .aspectFill,
                options: nil) { [weak self] (image, _) in
                    // FIXME: Handle error case for better experience
                    guard let image = image else { return }
                    
                    // Assign observable value from main thread
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
        }
    }
}
