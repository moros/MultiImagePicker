//
//  PhotoLibraryContainer.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Combine
import Photos

class PhotoLibraryContainer: ObservableObject {
    let objectWillChange = PassthroughSubject<[PHAsset], Never>()
    
    var assets = [PHAsset]() {
        didSet {
            objectWillChange.send(assets)
        }
    }
    
    func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            guard let self = self else { return }
            
            switch status {
            case .authorized:
                self.getAllPhotos()
            case .denied:
                print("PHPhotoLibrary.requestAuthorization: denied.")
                break
            case .notDetermined:
                print("PHPhotoLibrary.requestAuthorization: notDetermined.")
                break
            case .restricted:
                print("PHPhotoLibrary.requestAuthorization: restricted.")
                break
            @unknown default:
                print("PHPhotoLibrary.requestAuthorization: unknown default.")
                break
            }
        }
    }
    
    /// Fetchs all photos from gallery as `PHAsset` object
    private func getAllPhotos() {
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        var assetList = [PHAsset]()
        assets.enumerateObjects { (asset, index, stop) in
            assetList.append(asset)
        }
        DispatchQueue.main.async { [weak self] in
            self?.assets = assetList
        }
    }
}
