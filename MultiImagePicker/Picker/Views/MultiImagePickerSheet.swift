//
//  MultiImagePickerSheet.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import SwiftUI

struct MultiImagePickerSheet: View {
    
    @Binding var isPresented: Bool
    @State var doneAction: ([String]) -> ()
    
    @State var selectedIds = [String]()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                MultiImagePicker()
                    .onPreferenceChange(AssetImageSelectablePreferenceKey.self) { imageIds in
                        self.selectedIds = imageIds ?? []
                }
            }
            .navigationBarTitle("Photos", displayMode: .inline)
            .navigationBarItems(
                leading:
                Button(action: {
                    print("Close clicked!")
                    self.isPresented = false
                }, label: {
                    Text("Close")
                }),
                trailing:
                Button(action: {
                    print("Done clicked!")
                    
                    self.isPresented = false
                    
                    self.doneAction(self.selectedIds)
                }, label: {
                    Text("Done (\(selectedIds.count))").bold()
                }).disabled(selectedIds.count == 0)
            )
        }
    }
}
