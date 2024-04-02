//
//  CoreData15.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 25.03.2024.
//

import SwiftUI
import CoreData

// View - User Interface
// Model - Data point
// ViewModel - Manages the data for a view

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching request. \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + " 18"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    
}

struct CoreData15: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var fruit: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("Type a fruit", text: $fruit)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !fruit.isEmpty else { return }
                    vm.addFruit(text: fruit)
                    fruit = ""
                } label: {
                    Text("Add Fruit".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(10))
                }
                .padding(.horizontal)


                List {
                    ForEach(vm.savedEntities, id: \.self) { entity in
                        Text(entity.name ?? "")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                
                Spacer()
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreData15_Previews: PreviewProvider {
    static var previews: some View {
        CoreData15()
    }
}
