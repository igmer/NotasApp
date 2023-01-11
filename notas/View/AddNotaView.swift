//
//  AddNotaView.swift
//  notas
//
//  Created by Igmer Rodriguez on 10/1/23.
//

import SwiftUI

struct AddNotaView: View {
    @ObservedObject var modelNota : NotasViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(modelNota.updateItem != nil ? "Editar Nota":"Agregar Nota")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $modelNota.nota).foregroundColor(.gray).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            Divider()
            DatePicker("Seleccione una fecha",selection: $modelNota.fecha)
            Spacer()
            Button(action: {
                if modelNota.updateItem != nil{
                    modelNota.editNota(context: context)
                }else{
                    modelNota.saveNota(context: context)
                }
            }){
                Text("Guardar").foregroundColor(.white).bold()
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 24)
                .background(modelNota.nota == "" ? Color.gray :Color.blue)
                .disabled(modelNota.nota == "" ? true : false)
                .cornerRadius(8)
        }.padding()
    }
}
