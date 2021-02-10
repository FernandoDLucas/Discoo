//
//  AlbumRepositoryTest.swift
//  MusicTasteTests
//
//  Created by Fernando de Lucas da Silva Gomes on 08/02/21.
//

import XCTest
import CoreData
@testable import MusicTaste

class AlbumRepositoryTest: XCTestCase {

    var repository: AlbumRepository!

    var albumMock: Album!

    let persistentStore: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let persistentStore = appDelegate?.persistentContainer
        guard let container = persistentStore else { fatalError() }
        return container
    }()

    func createMock () -> Album {
        let entity = NSEntityDescription.entity(forEntityName: "Album", in: persistentStore.viewContext)
        let album = Album(entity: entity!, insertInto: persistentStore.viewContext)

        album.name = "Folklore"
        album.artist = "Taylor Swift"
        album.year = 2020
        return album
    }

    override func setUp() {
        repository = AlbumRepository()
        albumMock = createMock()
    }

    override func tearDown() {
        self.cleanRepository()
        repository = nil
        albumMock = nil
    }

    private func cleanRepository() {
        let albumArray = repository.getAll()
        for album in albumArray {
            _ = repository.delete(object: album)
        }
    }

    func test_add_true() {
        //given
        let album = AlbumDTO.empty

        //when
        let savedAlbum = repository.add(object: album)

        //then
        let fetchAlbum = repository.getAll()
        XCTAssert(fetchAlbum.contains(savedAlbum!))
    }

    func test_delete_true() {
        //given
        let album = createMock()

        //when
        let deletedAlbum = repository.delete(object: album)

        //then
        XCTAssertEqual(album, deletedAlbum)
    }

}
