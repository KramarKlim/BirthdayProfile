//
//  dataManager.swift
//  Birthday
//
//  Created by Клим on 04.07.2021.
//

import Foundation
import CoreData

class DataManager {
    
    static var shared = DataManager()
    
    var users: [Users] = []
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Birthday")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        let viewContext = persistentContainer.viewContext
        do {
            users = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveName(_ name: String, date: String) {
        let viewContext = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Users", in: viewContext) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? Users else { return }
        task.setValue(name, forKey: "name")
        task.name = name
        task.date = date
        users.append(task)
        saveContext()
    }
    
    func deleteTask(for index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            context.delete(objects[index])
        }
        users.remove(at: index)
        saveContext()
    }
    
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
}
