//
//  NotasViewModel.swift
//  notas
//
//  Created by Igmer Rodriguez on 10/1/23.
//

import Foundation
import CoreData
import SwiftUI


class NotasViewModel : ObservableObject{
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    //coredata
    func saveNota(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do{
            try context.save()
            print("guardo")
            nota = ""
            fecha = Date()
            show.toggle()
        }catch let error as NSError{
            print("No guardo", error.localizedDescription)
        }
    }
    func deleteNota(item: Notas, context: NSManagedObjectContext){
        context.delete(item)
        do {
            try context.save()
            print("eliminado")
        } catch let error as NSError {
            print("no se elimino", error.localizedDescription)
        }
    }
    func sendNota(item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    func editNota(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        
        do {
            try context.save()
            print("edito")
            show.toggle()
            nota = ""
            fecha = Date()
            updateItem = nil
        } catch let error as NSError {
            print("Error al editar", error.localizedDescription)
        }
    }
}
