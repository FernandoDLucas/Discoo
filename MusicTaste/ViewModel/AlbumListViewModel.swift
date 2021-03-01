//
//  AlbumListViewModel.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation
import CoreData

class AlbumListViewModel {

    var albuns = [AlbumViewModel]()

    let repository = AlbumRepository()

    weak open var delegate: NSFetchedResultsControllerDelegate? {
        didSet {
            repository.service.controllerDelegate = self.delegate
        }
    }

}

extension AlbumListViewModel {
    public func getAll() {
        let array = repository.getAll()
        let arrayList = array.compactMap(AlbumViewModel.init)
        self.albuns = arrayList
    }

    public var numberOfAlbuns: Int {
        return repository.numberOfItens
    }

    public func albumViewModelForRow (at index: Int) -> AlbumViewModel? {
        if numberOfAlbuns > index {
            let album = albuns[index]
            return album
        }
        return nil
    }

    public func albumForRow(at index: IndexPath) -> Album {
        let album = repository.objectAt(at: index)
        return album
    }

    public func deleteAlbum (album: Album) {
        _ = repository.delete(object: album)
    }

}
