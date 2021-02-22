//
//  AlbumDTO.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 04/02/21.
//

import Foundation
import UIKit

struct AlbumDTO {
    var name: String
    var artist: String
    var year: Int32
    var artwork: Data?
    var songs: NSSet?

    static var empty: AlbumDTO {
        AlbumDTO(name: "", artist: "", year: 0)
    }

    init(album: Album) {
        self.name = album.name!
        self.artist = album.artist!
        self.artwork = album.artwork
        self.year = album.year
    }
    init(name: String, artist: String, year: Int32){
        self.name = name
        self.artist = artist
        self.year = year
    }
}
