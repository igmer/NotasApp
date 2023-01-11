//
//  Home.swift
//  notas
//
//  Created by Igmer Rodriguez on 10/1/23.
//

import SwiftUI

struct Home: View {
    @StateObject var model = NotasViewModel()
    @Environment(\.managedObjectContext) var context
    
    /*@FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>*/
    @FetchRequest(entity: Notas.entity(), sortDescriptors: []
    ,predicate:NSPredicate(format: "fecha >= %@", Date() as CVarArg),
                  animation: .spring()) var results : FetchedResults<Notas>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results) { item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "***")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action:{
                            model.sendNota(item: item)
                        }){
                            Label(title:{Text("Editar")
                            }, icon: {Image(systemName: "pencil")})
                        }
                        Button(role: .destructive,action:{
                            model.deleteNota(item: item, context: context)
                        }){
                            
                            Label(title:{Text("Eliminar")
                            }, icon: {Image(systemName: "trash")})
                        }
                    }))
                }
            }.navigationBarTitle("Notas")
                .navigationBarItems(trailing: Button(action:{
                    model.show.toggle()
                }){
                    Image(systemName: "plus").font(.title)
                        .foregroundColor(.blue)
                }).sheet(isPresented: $model.show, content: {
                    AddNotaView(modelNota: model)
                })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
