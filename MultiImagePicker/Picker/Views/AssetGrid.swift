//
//  AssetGrid.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import Photos
import SwiftUI

struct AssetGrid: View {
    
    @Binding var data: [PHAsset]
    @State var columns: Int = Constants.gridColumns
    
    @State var selectable: Bool = false
    @State var selectedIds = [String]()
    
    private var rowTotalSpace: CGFloat {
        Constants.cellSpacing * CGFloat(columns + 1)
    }
    
    var body: some View {
        var imageDictionary = [[PHAsset]]()

        _ = data.publisher
            .collect(columns)
            .collect()
            .sink(receiveValue: { imageDictionary = $0 })
        
        return GeometryReader { geometryReader in
            List {
                ForEach(0..<imageDictionary.count, id: \.self) { array in
                    HStack(spacing: 0) {
                        ForEach(imageDictionary[array], id: \.self) { asset in
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
