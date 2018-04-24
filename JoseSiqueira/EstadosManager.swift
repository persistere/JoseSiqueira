//
//  EstadosManager.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 24/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import CoreData

class EstadosManager {
    
    static let shared = EstadosManager()
    var estados: [Estado] = []
    
    func loadEstados(with context: NSManagedObjectContext ) {
        let fetchRequest: NSFetchRequest<Estado> = Estado.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            estados = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteEstados(index: Int, context: NSManagedObjectContext) {
        let estado = estados[index]
        context.delete(estado)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        
    }
}
