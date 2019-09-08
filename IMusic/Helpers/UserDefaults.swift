//
//  UserDefaults.swift
//  Apple Music Swiftbook
//
//  Created by Алексей Пархоменко on 28/08/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation



extension UserDefaults {
    
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        guard let savedTracks = defaults.object(forKey: UserDefaults.favouriteTrackKey) as? Data else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
        return decodedTracks
    }
    
    
    func deleteTrack(track: SearchViewModel.Cell) {
        let tracks = savedTracks()
        let filteredTracks = tracks.filter { (t) -> Bool in
            return t.trackName != track.trackName && t.artistName != track.artistName
        }
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: filteredTracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }

    }

}
