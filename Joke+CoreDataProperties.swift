//
//  Joke+CoreDataProperties.swift
//  KevJokes
//
//  Created by KEEVIN MITCHELL on 11/17/20.
//
//

import Foundation
import CoreData


extension Joke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        return NSFetchRequest<Joke>(entityName: "Joke")
    }

    @NSManaged public var setup: String
    @NSManaged public var punchline: String
    @NSManaged public var rating: String

}

extension Joke : Identifiable {

}
