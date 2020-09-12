//
//  CoreDataService.swift
//  iTunesAPI
//
//  Created by Азизбек on 06.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService {

  static let shared = CoreDataService()

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "RecentModel")
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func save(recents: String) {
    let managedContext = persistentContainer.viewContext
    let recent = Recent(context: managedContext)
    recent.name = recents
    saveContext()
  }

  func fetch() -> [Recent] {
    let managedContext = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Recent>(entityName: "Recent")
    do {
      let recents = try managedContext.fetch(fetchRequest)
      return recents
    } catch let error {
      print(error.localizedDescription)
    }
    return [Recent]()
  }

  func delete(resent: Recent) {
    let managedContext = persistentContainer.viewContext
    managedContext.delete(resent)

    do {
      try managedContext.save()
      print("Удачное удаление")
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func entityIsEmpty() -> Bool {

    let managedContext = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Recent>(entityName: "Recent")
    do {
      let count = try managedContext.count(for: fetchRequest)
      if count == 0 {
        return true
      } else {
        return false
      }
    } catch let error {
      print(error.localizedDescription)
    }
    return false
  }
}
