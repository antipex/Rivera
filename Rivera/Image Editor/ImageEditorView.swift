//
//  ImageEditorView.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import SwiftUI

struct ImageEditorView: View {

    var image: RemoteImage
//    var editedImage: RemoteImage

    var body: some View {
        RemoteImageView(url: image.url!, placeholder: Text("Loading..."))
            .scaledToFit()
            .navigationBarTitle(image.name)
    }
}

//struct ImageEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageEditorView(image: nil)
//    }
//}
