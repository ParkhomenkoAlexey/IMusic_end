//
//  SearchModels.swift
//  IMusic
//
//  Created by Алексей Пархоменко on 12/08/2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getTracks(searchTerm: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTracks(searchResponse: SearchResponse?)
        case presentFooterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTracks(searchViewModel: SearchViewModel)
        case displayFooterView
      }
    }
  }
}

//
//struct SearchViewModel {
//    struct Cell: TrackCellViewModel {
//        var iconUrlString: String?
//        var trackName: String
//        var collectionName: String
//        var artistName: String
//        var previewUrl: String?
//        
//    }
//    
//    let cells: [Cell]
//}

class SearchViewModel: NSObject, NSCoding {
    
@objc(_TtCC21Apple_Music_Swiftbook15SearchViewModel4Cell)class Cell: NSObject, NSCoding, TrackCellViewModel, Identifiable {
    
    var id = UUID()
        var iconUrlString: String?
        var trackName: String
        var artistName: String
        var collectionName: String
        let previewUrl: String?
        
        init(iconUrlString: String?, trackName: String, artistName: String, collectionName: String, previewUrl: String?) {
            self.iconUrlString = iconUrlString
            self.trackName = trackName
            self.artistName = artistName
            self.collectionName = collectionName
            self.previewUrl = previewUrl
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(iconUrlString, forKey: "iconUrlString")
            coder.encode(trackName, forKey: "trackName")
            coder.encode(artistName, forKey: "artistName")
            coder.encode(collectionName, forKey: "collectionName")
            coder.encode(previewUrl, forKey: "previewUrl")
        }
        
        required init?(coder: NSCoder) {
            iconUrlString = coder.decodeObject(forKey: "iconUrlString") as? String? ?? ""
            trackName = coder.decodeObject(forKey: "trackName") as? String ?? ""
            artistName = coder.decodeObject(forKey: "artistName") as? String ?? ""
            collectionName = coder.decodeObject(forKey: "collectionName") as? String ?? ""
            previewUrl = coder.decodeObject(forKey: "previewUrl") as? String? ?? ""
        }
    }
    
    let cells: [Cell]
    
    init(cells: [Cell]) {
        self.cells = cells
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(cells, forKey: "cells")
    }
    
    required init?(coder: NSCoder) {
        cells = coder.decodeObject(forKey: "cells") as? [SearchViewModel.Cell] ?? []
    }
}
