//
//  AlbumFields.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

enum AlbumForm {
    case create

    var fields: [String] {
        switch self {
        case .create:
        return ["Título", "Artista", "Ano"]
        }
    }
}

enum AlbumFields: String {
    case name = "Título"
    case artist = "Artista"
    case year = "Ano"
}
