//
//  ImageGridView.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import SwiftUI

struct ImageGridView: View {

    struct Constants {
        static let gridSpacing: CGFloat = 10
    }

    @ObservedObject var viewModel = ImageGridViewModel(imageApi: ImageApi())

    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]

        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Constants.gridSpacing) {
                    ForEach(viewModel.images) { image in
                        NavigationLink(destination: ImageEditorView(image: image)) {
                            RemoteImageView(url: image.url!, placeholder: Text("Loading..."))
                                .frame(minWidth: 50, maxWidth: .infinity)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }.padding(.horizontal)
            }
            .navigationBarTitle("Images")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
    }
}
