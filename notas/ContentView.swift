//
//  ContentView.swift
//  notas
//
//  Created by Igmer Rodriguez on 10/1/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Home()
    }
}
