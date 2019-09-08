//
//  Library.swift
//  IMusic
//
//  Created by Алексей Пархоменко on 03/09/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI
import SDWebImage
import URLImage



struct Library: View {
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    
    
    var tabBarDelegate: MainTabBarControllerDelegate?
 
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            self.track = self.tracks[0]
                            let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
                            tabBarVC?.trackDetailView.delegate = self
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        }, label: {
                            Image(systemName: "play.fill").frame(width: geometry.size.width / 2 - 10, height: 50)
                        }).accentColor(Color.init(#colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9732982516, green: 0.9723327756, blue: 0.9892340302, alpha: 1))).cornerRadius(10)
                        
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
                        }, label: {
                            Image(systemName: "arrow.2.circlepath").frame(width: geometry.size.width / 2 - 10, height: 50)
                            
                        }).accentColor(Color.init(#colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9732982516, green: 0.9723327756, blue: 0.9892340302, alpha: 1))).cornerRadius(10)
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                List {
                    ForEach(tracks) { track in
                        
                        LibraryCell(cell: track)
                            
                            .gesture(
                                LongPressGesture()
                                    .onEnded { _ in
                                        print("Pressed!")
                                        self.showingAlert = true
                                        
                                }.simultaneously(with: TapGesture()
                                    
                                    .onEnded { _ in
                                        self.track = track
                                        let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
                                        tabBarVC?.trackDetailView.delegate = self
                                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: track)
                                    }
                                )
                        )
                        
                    }
                        
                    .onDelete(perform: delete)
                    
                }
            }
                
                .actionSheet(isPresented: $showingAlert) {
                    ActionSheet(title: Text("Are you sure you want to delete this track?"),
                                buttons: [
                                    .destructive(Text("Delete")) {
                                        print("Deleting: \(self.track.trackName)")
                                        self.delete(track: self.track)
                                        
                        },
                                    .cancel()])
                }
            .navigationBarTitle("Library")
            
           
            } // NavigationView
    }
    
    
    func delete(at offsets: IndexSet) {
        
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}



struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell

  var body: some View {
    HStack {
        
        URLImage(URL(string: cell.iconUrlString ?? "")!).resizable().cornerRadius(2).frame(width: 60, height: 60)

        
        VStack(alignment: .leading) {
            Text("\(cell.trackName)")
                .font(.body)
            Text("\(cell.artistName)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
  }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        //        print(track.trackName)
                let index = tracks.firstIndex(of: track)
                guard let myIndex = index else { return nil }
        //        print("myIndex:", myIndex)
                
                var nextTrack: SearchViewModel.Cell
                if myIndex - 1 == -1 {
                    nextTrack = tracks[tracks.count - 1]
                } else {
                    
                    nextTrack = tracks[myIndex - 1]
                }
        //        print(nextTrack.trackName)
                self.track = nextTrack
                return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
//        print(track.trackName)
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
//        print("myIndex:", myIndex)
        
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
//        print(nextTrack.trackName)
        self.track = nextTrack
        return nextTrack
    }
    
    
}


