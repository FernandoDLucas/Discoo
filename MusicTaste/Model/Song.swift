//
//  Song+CoreDataClass.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//
//

import Foundation
import CoreData

@objc(Song)
public class Song: NSManagedObject {

}


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var name: String?
    @NSManaged public var review: String?
    @NSManaged public var album: Album?

}

extension Song : Identifiable {

}
