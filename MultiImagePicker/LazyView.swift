//
//  LazyView.swift
//  MultiImagePicker
//
//  Created by dmason on 8/4/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

#if DEBUG
struct LazyView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView(Text("Hello World!"))
    }
}
#endif
