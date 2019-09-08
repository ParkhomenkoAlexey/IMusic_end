//
//  TrackCell.swift
//  IMusic
//
//  Created by Алексей Пархоменко on 13/08/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftUI

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
    
}

class TrackCell: UITableViewCell {
    
    static let reuseId = "TrackCell"
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
        
    }
    
    var cell: SearchViewModel.Cell?
    
    func set(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavorited = savedTracks.firstIndex(where: { $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName }) != nil
        if hasFavorited {
            addTrackButton.isHidden = true
        } else {
            addTrackButton.isHidden = false
        }

        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        
    }
    
  
    @IBAction func addTrackAction(_ sender: Any) {
        print("saving into UserDefaults")
        addTrackButton.isHidden = true
        guard let cell = cell else { return }
        var listOfTracks = UserDefaults.standard.savedTracks()
        
       
        
        
        listOfTracks.append(cell)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
}
