//
//  ListVM.swift
//  Movie
//
//  Created by Edo Oktarifa on 23/04/21.
//

import Foundation
import UIKit
import CoreData

class ListVM {
    
    let apiManager = APIManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var showListMovie = [Movies]()
    
    func request (completion: @escaping ([Movies])->Void, error: @escaping (RequestError) -> Void){
        let param = ["api_key":"c94886e2ee915fe4f057c55b542dab15"]
        
        apiManager.requestData(url: Constants.base_url, method: .get, parameters: param) { (result) in
            
            switch result{
            case .success(let data):
                do {
                    self.deleteAllData(entity: "Movies")
                    let listMovie = try JSONDecoder().decode(ListMovieModel.self, from: data)
                    
                    for data in listMovie.production_companies ?? []{
                        self.saveDataToCoreData(input: data)
                    }
                    
                    completion(self.showListMovie)
                } catch {
                    
                }
                
            case .failure(let failure):
                self.loadItems()
                switch failure {
                case .connectionError:
                    error(RequestError.connectionError)
                default:
                    error(RequestError.unknownError)
                }
                
                
            }
        }
    }
    
    func saveDataToCoreData(input data: Production_companies){
        let inputNewData = Movies(context: context)
        inputNewData.title = data.name
        inputNewData.img = data.logo_path
        saveItems()
        
        self.loadItems()
    }
    
    //MARK: - save data To CoreData
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteAllData(entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func loadItems(with request: NSFetchRequest<Movies> = Movies.fetchRequest()){
        do {
            showListMovie = try context.fetch(request)
            print(showListMovie.count)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
    
    func loadData(completion: @escaping ([Movies])->Void){
        loadItems()
        completion(showListMovie)
    }
    
}
