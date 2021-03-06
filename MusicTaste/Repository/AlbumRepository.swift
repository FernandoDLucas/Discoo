//
//  AlbumRepository.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation
import CoreData

class AlbumRepository {

    let service = CoreDataService<Album>()
    var albuns: [Album] = []

    func addSong(title: String, album: Album) -> Album? {
        return nil
    }

    func objectAt(at index: IndexPath) -> Album {
        return service.fetchedResultsController.object(at: index)
    }

     var numberOfItens: Int {
    return service.fetchedResultsController.fetchedObjects?.count ?? 0
    }
}

extension AlbumRepository: Repository {
    typealias Object = Album
    typealias ObjectDTO = AlbumDTO

    func getAll() -> [Album] {
        guard let albuns = service.fetchedResultsController.fetchedObjects else { return self.albuns }
        self.albuns = albuns
        return albuns
    }

    func add(object: AlbumDTO) -> Album? {
        let album = service.new()
        album?.name = object.name
        album?.artist = object.artist
        album?.artwork = object.artwork
        album?.year = object.year
        if service.save() {return album}
        return nil
    }

    func delete(object: Album) -> Album? {
        guard let album = service.delete(object: object) else { return nil }
        return album
    }
}
