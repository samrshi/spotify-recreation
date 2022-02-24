//
//  MusicPlayerView.swift
//  spotify-recreation
//
//  Created by Samuel Shi on 2/17/22.
//

import SwiftUI

struct MusicPlayerView: View {
    @State private var durationPlayed: Double = 0.0
    @State private var isPlaying: Bool = true
    
    @Binding var song: Song
    @Binding var shuffle: Bool
    @Binding var repeatSong: Bool
    
    let rewind: () -> Void
    let fastforward: () -> Void
    
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
        
    var body: some View {
        VStack(spacing: 28) {
            topBar
            Spacer()
            albumArt
            Spacer()
                
            HStack {
                songInfo
                Spacer()
                favoriteButton
            }
                
            songTimer
            controls
            Spacer()
            bottomBar
        }
        .padding()
        .onReceive(timer, perform: didReceiveTimerEvent)
        .fullScreenBackground(background)
    }
    
    var topBar: some View {
        HStack {
            Image(systemName: "chevron.down")
            Spacer()
            Text(song.playingFrom)
                .font(.caption)
                .bold()
            Spacer()
            Image(systemName: "ellipsis")
        }
    }
    
    var albumArt: some View {
        Image(song.imageName)
            .resizable()
            .scaledToFit()
    }
    
    var songInfo: some View {
        VStack(alignment: .leading) {
            Text(song.title)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(song.artist)
                .font(.caption)
                .fontWeight(.light)
        }
    }
    
    var favoriteButton: some View {
        Button(action: toggleFavorited, label: {
            Image(systemName: song.isFavorited ? "suit.heart.fill" : "suit.heart")
                .font(.title)
                .foregroundColor(song.isFavorited ? .green : .secondary)
        })
    }
    
    var songTimer: some View {
        VStack(spacing: 4) {
            SpotifySliderView(value: $durationPlayed, maxValue: song.length)
            
            HStack {
                Text(currentDuration)
                Spacer()
                Text(totalDuration)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .accentColor(.white)
    }
    
    var controls: some View {
        HStack {
            Image(systemName: "shuffle")
                .font(.title2)
                .toggleable(isOn: $shuffle, onColor: .green, offColor: .white)
            
            Spacer()
            
            Button(action: didTapRewind, label: {
                Image(systemName: "backward.end.fill")
                    .font(.largeTitle)
            })
            
            Spacer()
            
            Button(action: togglePlayStatus, label: {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            })
            
            Spacer()
            
            Button(action: didTapFastforward, label: {
                Image(systemName: "forward.end.fill")
                    .font(.largeTitle)
            })
            
            Spacer()
            
            Image(systemName: "arrow.triangle.2.circlepath")
                .font(.title2)
                .toggleable(isOn: $repeatSong, onColor: .green, offColor: .white)
        }
        .foregroundColor(.white)
    }
    
    var bottomBar: some View {
        HStack(spacing: 28) {
            Label("SAM'S AIRPODS PRO", systemImage: "airpodspro")
                .font(.caption)
                .foregroundColor(.green)

            Spacer()
            
            Image(systemName: "square.and.arrow.up")
            Image(systemName: "list.bullet.below.rectangle")
        }
    }
    
    var background: some View {
        LinearGradient(colors: [song.topColor, song.bottomColor],
                       startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    var currentDuration: String {
        let minutes = Int(durationPlayed / 60)
        let seconds = Int(durationPlayed) % 60
        let secondsString = String(format: "%02d", seconds)
        return "\(minutes):\(secondsString)"
    }
    
    var totalDuration: String {
        let minutes = Int(song.length / 60)
        let seconds = Int(song.length) % 60
        let secondsString = String(format: "%02d", seconds)
        return "\(minutes):\(secondsString)"
    }
    
    var durationRemaining: String {
        let remaining = song.length - durationPlayed
        let minutes = Int(remaining / 60)
        let seconds = Int(remaining) % 60
        let secondsString = String(format: "%02d", seconds)
        return "-\(minutes):\(secondsString)"
    }
    
    func toggleFavorited() {
        song.isFavorited.toggle()
    }
    
    func togglePlayStatus() {
        isPlaying.toggle()
    }
    
    func didTapRewind() {
        changeSong(action: rewind)
    }
    
    func didTapFastforward() {
        changeSong(action: rewind)
    }
    
    func changeSong(action: () -> Void) {
        isPlaying = true
        durationPlayed = 0
        action()
    }
    
    func didReceiveTimerEvent(_: Date) {
        if isPlaying { durationPlayed += 0.001 }
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    @State private static var song: Song = .paradise
    @State private static var shuffle: Bool = false
    @State private static var repeatSong: Bool = false
    
    static var previews: some View {
        MusicPlayerView(song: $song,
                        shuffle: $shuffle,
                        repeatSong: $repeatSong,
                        rewind: {}, fastforward: {})
            .preferredColorScheme(.dark)
    }
}
