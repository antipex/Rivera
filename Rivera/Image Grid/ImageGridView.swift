//
//  ImageGridView.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import SwiftUI

struct ImageGridView: View {

    @ObservedObject var viewModel = ImageGridViewModel(imageApi: ImageApi())

    var body: some View {
        List(viewModel.images) { image in
            Text(image.name)
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
    }
}
