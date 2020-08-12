//
//  ContentView.swift
//  MultiImagePicker
//
//  Created by dmason on 8/3/20.
//

import SwiftUI

struct ContentView: View {
    @State var sheetPickerShown = false
    
    var body: some View {
        VStack {
            MultiImagePicker()
                .onPreferenceChange(AssetImageSelectablePreferenceKey.self) { imageIds in
                    print("imageIds: \(String(describing: imageIds))")
                }
            Button(action: {
                self.sheetPickerShown = true
            }) {
                Text("Show Sheet Image Picker")
            }
            .padding()
            .sheet(isPresented: self.$sheetPickerShown, content: {
                MultiImagePickerSheet(isPresented: self.$sheetPickerShown, doneAction: { _ in
                    
                })
            })
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
