//
//  EditAlbumViewModel.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 22/02/21.
//

import Foundation

class EditAlbumViewModel {

    let form = AlbumForm.create
    var albumDTO : AlbumDTO
    let repository = AlbumRepository()
    let album: Album

    var handleDismiss: (() -> Void)?

    init(with: Album) {
        self.album = with
        self.albumDTO = AlbumDTO(album: with)
    }
}

extension EditAlbumViewModel {

    var ordenatedValues: [String?] {
        return [self.album.name, self.album.artist, String(self.album.year)]
    }
    var numberOfRows: Int {
        return form.fields.count
    }

    public func fieldName(row: Int) -> String? {
        return form.fields[row]
    }

    public func fieldValue(row: Int) -> String {
        guard let fieldValue = ordenatedValues[row] else {return ""}
        return fieldValue
    }

    func addAlbum() {
        _ = repository.add(object: albumDTO)
        handleDismiss?()
    }

    func getImage(data: Data) {
        self.albumDTO.artwork = data
    }

    @objc func saveButton() {
        if let image = self.albumDTO.artwork{
            self.album.artwork = image
        }
        self.album.artist = self.albumDTO.artist
        self.album.year = self.albumDTO.year
        self.album.name = self.albumDTO.name
        _ = repository.service.save()
        handleDismiss?()
    }

    @objc func cancelButton() {
        handleDismiss?()
    }

}

extension EditAlbumViewModel: AlbumFieldsDelegate {
    func didUpdateTextField(text: String, field: AlbumFields) {
        switch field {
        case .name:
            self.albumDTO.name = text
        case .artist:
            self.albumDTO.artist = text
        case .year:
            self.albumDTO.year = Int32(text) ?? 0
        }
    }
}
