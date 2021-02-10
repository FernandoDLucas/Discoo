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

    override func setUp() {
        self.viewModel = AlbumViewModel(album: album)
        service = CoreDataService<Album>()
        albumList = []
    }

    override func tearDown() {
        service = nil
        albumList = []
    }

    func createMockList() {
    }
}
