//
//  MultiImagePicker.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Photos
import SwiftUI

struct MultiImagePicker : View {
    @ObservedObject var photoLibrary = PhotoLibraryContainer()
    
    @State var assets: [PHAsset] = [PHAsset]()
    
    var body: some View {
        VStack {
            AssetGrid(data: self.$assets, columns: Constants.gridColumns, selectable: true)
        }
        .padding(5)
        .onAppear(perform: {
            self.reload()
        })
        .onReceive(photoLibrary.objectWillChange, perform: { data in
            self.assets = data
        })
    }
    
    private func reload() {
        photoLibrary.requestAuthorization()
    }
}
