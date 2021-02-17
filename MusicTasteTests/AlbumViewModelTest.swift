//
//  AlbumViewModelTest.swift
//  MusicTasteTests
//
//  Created by Fernando de Lucas da Silva Gomes on 09/02/21.
//

import XCTest
import CoreData
@testable import MusicTaste

class AlbumViewModelTest: XCTestCase {

    var viewModel: AlbumViewModel!
    var service: CoreDataService<Album>!
    var album: Album!
    var albumList: [Album]!
    var songList: [SongViewModel]!

    override func setUp() {
        self.viewModel = AlbumViewModel(album: album)
        service = CoreDataService<Album>()
        albumList = []
    }

    let persistentStore: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let persistentStore = appDelegate?.persistentContainer
        guard let container = persistentStore else { fatalError() }
        return container
    }()

    override func tearDown() {
        service = nil
        albumList = []
    }
//    func createMockList() -> [SongViewModel] {
//
//        var songList = [SongViewModel]()
//        for _ in 0..<10 {
//            let newSong = Song.init(context: persistentStore.viewContext)
//            let viewModel = SongViewModel.init(newSong)
//            songList.append(viewModel)
//        }
//        return songList
//    }
//
//    private func cleanRepository() {
//        for song in songList {
//            _ = viewModel.repository.deleteAll()
//        }
//    }
}
