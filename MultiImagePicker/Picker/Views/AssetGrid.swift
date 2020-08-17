//
//  AssetGrid.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Combine
import Photos
import SwiftUI

class GridLoader: ObservableObject {
    var objectWillChange = PassthroughSubject<[[PHAsset]], Never>()
    @Binding var data: [PHAsset]
    
    var imageDictionary = [[PHAsset]]() {
        didSet {
            objectWillChange.send(imageDictionary)
        }
    }

    init(columns: Int, data: Binding<[PHAsset]>) {
        self._data = data
        _ = self.data.publisher
            .collect(columns)
            .collect()
            .sink(receiveValue: { self.imageDictionary = $0 })
    }
}

struct AssetGrid: View {
    
    @Binding var data: [PHAsset]
    @State var columns: Int = Constants.gridColumns
    @ObservedObject var model: GridLoader
    
    @State var selectable: Bool = false
    @State var selectedIds = [String]()
    
    private var rowTotalSpace: CGFloat {
        Constants.cellSpacing * CGFloat(columns + 1)
    }
    
    var body: some View {
        
        return GeometryReader { geometryReader in
            List {
                ForEach(0..<self.model.imageDictionary.count, id: \.self) { array in
                    HStack(spacing: 0) {
                        ForEach(self.model.imageDictionary[array], id: \.self) { asset in
                            VStack {
                                if self.selectable {
                                    AssetImageSelectableView(
                                        asset: asset,
                                        size: self.getImageSize(width: geometryReader.size.width),
                                        selectedIds: self.$selectedIds
                                    )
                                    .padding(.top, Constants.cellSpacing)
                                    .padding(.leading, Constants.cellSpacing)
                                }
                                else {
                                    AssetImageView(
                                        asset: asset,
                                        size: self.getImageSize(width: geometryReader.size.width)
                                    )
                                    .padding(.top, Constants.cellSpacing)
                                    .padding(.leading, Constants.cellSpacing)
                                }
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
            }.onAppear {
                UITableView.appearance().separatorStyle = .none
            }.onDisappear {
                UITableView.appearance().separatorStyle = .singleLine
            }
        }
    }
    
    func getImageSize(width: CGFloat) -> CGSize {
        let size = (width - rowTotalSpace) / CGFloat(columns)
        return CGSize(width: size, height: size)
    }
}
