//
//  CreateAlbumViewModel.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation

class CreateAlbumViewModel{
    
    let form = AlbumForm.create
    var albumDTO = AlbumDTO.empty
    let repository = AlbumRepository()
    
    var handleDismiss: (() -> Void)?
}

extension CreateAlbumViewModel{
    
    var numberOfRows : Int{
        return form.fields.count
    }
    
    public func fieldName(row: Int) -> String? {
        return form.fields[row]
    }
    
    func addAlbum(){
        repository.add(object: albumDTO)
        handleDismiss?()
    }
    
    func getImage(data: Data) {
        self.albumDTO.artwork = data
    }
    
    @objc func saveButton(){
        repository.add(object: albumDTO)
        handleDismiss?()
    }
    
    @objc func cancelButton(){
        handleDismiss?()
    }
    
}

extension CreateAlbumViewModel: AlbumFieldsDelegate{
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
