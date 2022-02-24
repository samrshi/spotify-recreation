//
//  Song.swift
//  spotify-recreation
//
//  Created by Samuel Shi on 2/17/22.
//

import SwiftUI

struct Song {
    let title: String
    let artist: String
    let length: TimeInterval
    let playingFrom: String
    
    let imageName: String
    let topColor: Color
    let bottomColor: Color
    
    var isFavorited: Bool = false
}

extension Song {
    static var paradise: Song {
        Song(title: "Paradise",
             artist: "Rex Orange County",
             length: 217,
             playingFrom: "Bcos U Will Never B Free",
             imageName: "paradise",
             topColor: .paradiseTop,
             bottomColor: .paradiseBottom)
    }

    static var sweatpants: Song {
        Song(title: "IV. Sweatpants",
             artist: "Childish Gambino",
             length: 180,
             playingFrom: "Because the Internet",
             imageName: "sweatpants",
             topColor: .sweatpantsTop,
             bottomColor: .sweatpantsBottom)
    }
}
