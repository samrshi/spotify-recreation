//
//  ContentView.swift
//  spotify-recreation
//
//  Created by Samuel Shi on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var songs: [Song] = [.paradise, .sweatpants]
    @State private var songIndex = 0

    @State private var shuffle: Bool = false
    @State private var repeatSong: Bool = false

    var body: some View {
        MusicPlayerView(song: $songs[songIndex],
                        shuffle: $shuffle,
                        repeatSong: $repeatSong,
                        rewind: rewind,
                        fastforward: fastforward)
            .preferredColorScheme(.dark)
    }

    func rewind() {
        guard songIndex > 0 else { return }
        songIndex -= 1
    }

    func fastforward() {
        guard songIndex < songs.count - 1 else { return }
        songIndex += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
