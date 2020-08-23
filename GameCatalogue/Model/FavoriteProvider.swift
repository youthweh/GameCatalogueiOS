//
//  FavoriteProvider.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 31/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation
import CoreData
import UIKit
 
class FavoriteProvider {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MemberFavorite")
        
        container.loadPersistentStores { storeDesription, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
           let taskContext = persistentContainer.newBackgroundContext()
           taskContext.undoManager = nil
           
           taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
           return taskContext
       }
    
    
    func getAllMember(completion: @escaping(_ members: [FavoriteModel]) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var members: [FavoriteModel] = []
                for result in results {
                    let member = FavoriteModel(id: result.value(forKeyPath: "id") as? Int32, name: result.value(forKeyPath: "name") as? String, deskripsi: result.value(forKeyPath: "deskripsi") as? String, released: result.value(forKeyPath: "released") as? String, imagefav: result.value(forKeyPath: "imagefav") as? String, rating: result.value(forKeyPath: "rating") as? Double)
                    
                    members.append(member)
                }
                completion(members)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getMember(_ id: Int, completion: @escaping(_ members: FavoriteModel) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first{
                   let member = FavoriteModel(id: result.value(forKeyPath: "id") as? Int32, name: result.value(forKeyPath: "name") as? String, deskripsi: result.value(forKeyPath: "deskripsi") as? String, released: result.value(forKeyPath: "released") as? String, imagefav: result.value(forKeyPath: "imagefav") as? String, rating: result.value(forKeyPath: "rating") as? Double)
                    completion(member)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    /*func createMember(_ name: String, _ released: String, _ imagefav: String, _ rating: Double, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                self.getMaxId { (id) in
                    member.setValue(id+1, forKeyPath: "id")
                    member.setValue(name, forKeyPath: "name")
                    member.setValue(released, forKeyPath: "released")
                    member.setValue(imagefav, forKeyPath: "imagefav")
                    member.setValue(rating, forKeyPath: "rating")
                    
                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }*/
    
    func createMember(_ id:Int,_ name: String,_ deskripsi:String, _ released: String, _ imagefav: String, _ rating: Double, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
               // self.getMaxId { (id) in
                    member.setValue(id, forKeyPath: "id")
                    member.setValue(name, forKeyPath: "name")
                    member.setValue(deskripsi, forKeyPath: "deskripsi")
                    member.setValue(released, forKeyPath: "released")
                    member.setValue(imagefav, forKeyPath: "imagefav")
                    member.setValue(rating, forKeyPath: "rating")
                    
                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
               // }
            }
        }
    }
    
    
    func updateMember(_ id: Int, _ name: String,_ deskripsi:String, _ released: String, _ imagefav: String, _ rating: Double, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            if let result = try? taskContext.fetch(fetchRequest), let member = result.first as? Favorite{
                member.setValue(name, forKeyPath: "name")
                member.setValue(name, forKeyPath: "deskripsi")
                member.setValue(released, forKeyPath: "released")
                member.setValue(imagefav, forKeyPath: "imagefav")
                member.setValue(rating, forKeyPath: "rating")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func getMaxId(completion: @escaping(_ maxId: Int) -> ()) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastMember = try taskContext.fetch(fetchRequest)
                if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int{
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAllMember(completion: @escaping() -> ()) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
    
    func deleteMember(_ id: Int, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
    
    func addMemberDummy(completion: @escaping() -> ()){
        for member in memberDummies{
            if let id = member.id, let name = member.name,let deskripsi = member.deskripsi, let released = member.released, let imagefav = member.imagefav, let rating = member.rating {
                self.createMember(Int(id),name,deskripsi, released, imagefav, rating){
                    completion()
                }
            }
        }
    }
    
    
}
