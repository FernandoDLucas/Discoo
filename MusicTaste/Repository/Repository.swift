//
//  Repository.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

protocol Repository {
    associatedtype Object
    associatedtype ObjectDTO

    func getAll() -> [Object]
    
    func add(object: ObjectDTO) -> Object?
    
    func addSong(title: String) -> Object?
}
