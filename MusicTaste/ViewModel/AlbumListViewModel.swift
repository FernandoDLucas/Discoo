//
//  AlbumListViewModel.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation

class AlbumListViewModel {

    var albuns = [AlbumViewModel]()

    let repository = AlbumRepository()

    var handleUpdate: (() -> Void)?

}

extension AlbumListViewModel {
    public func getAll() {
        let array = repository.getAll()
        let arrayList = array.compactMap(AlbumViewModel.init)
        self.albuns = arrayList
        self.handleUpdate?()
    }

    public var numberOfAlbuns: Int {
        return self.albuns.count
    }

    public func albumForRow (at index: Int) -> AlbumViewModel? {
        if numberOfAlbuns > index {
            let album = albuns[index]
            return album
        }
        return nil
    }

    public func deleteAlbum (album: Album) {
        _ = repository.delete(object: album)
        handleUpdate?()
    }

}
