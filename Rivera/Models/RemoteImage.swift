//
//  Image.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import UIKit

struct RemoteImage: Codable, Identifiable {

    enum Category: String, Codable {
        case `default` = "category.default"
    }

    enum Units: String, Codable {
        case mm
    }

    struct Tags: Codable {
        var sizedescription: String
        var sizescale: CGFloat
        var sizewidth: CGFloat
        var sizewidthArc: CGFloat
        var sizeheight: CGFloat
        var sizeheightarc: CGFloat
        var sizedepth: CGFloat
        var sizedeptharc: CGFloat
        var sizeunits: Units
    }

    var id = UUID()
    var index: Int
    var name: String
    var number: String
    var image: String
    var category: Category
    var version: String
//    var tags: Tags

    enum CodingKeys: String, CodingKey {
        case index
        case name
        case number
        case image
        case category
        case version
//        case tags
    }

}
