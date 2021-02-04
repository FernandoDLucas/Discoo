//
//  Album+CoreDataClass.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//
//

import Foundation
import CoreData

@objc(Album)
public class Album: NSManagedObject {

}



extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var name: String?
    @NSManaged public var artist: String?
    @NSManaged public var year: Int32
    @NSManaged public var artwork: Data?
    @NSManaged public var songs: NSSet?

}

// MARK: Generated accessors for songs
extension Album {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}

extension Album : Identifiable {

}


struct Schema {
    enum Field: String {
            case name
        }
    }
