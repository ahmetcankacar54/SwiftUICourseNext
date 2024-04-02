//
//  MultipleSheets7.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 23.03.2024.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}


// Problem is passing item through the sheet to the next View
// There are three approach for solving this problem
// 1 - Use a Binding
// 2 - Use a Multiple .sheet
// 3 - Use a $item

/// MARK: APPROACH 1
// This might not be work for every situation
// You might want to be static version at the next view
//struct MultipleSheets7: View {
//
//    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
//    @State var isPresented: Bool = false
//
//    var body: some View {
//        VStack (spacing: 20) {
//            Button("Button 1") {
//                selectedModel = RandomModel(title: "Numero uno")
//                isPresented.toggle()
//            }
//            Button("Button 2") {
//                selectedModel = RandomModel(title: "Numero secundo")
//                isPresented.toggle()
//            }
//        }
//        .sheet(isPresented: $isPresented) {
//            nextScreen(selectedItem: $selectedModel)
//        }
//    }
//}
//struct nextScreen: View {
//
//    @Binding var selectedItem: RandomModel
//
//    var body: some View {
//        VStack {
//            Text(selectedItem.title)
//            Text(selectedItem.id)
//        }
//        .font(.title)
//    }
//}


/// MARK: APPROACH 2
// You can easily tell the ineffiency is at the high level just by looking
// We need to create bool variables and sheets for every item
// This is going to give a huge problem when we have more than 10 sheets like this
//struct MultipleSheets7: View {
//
//    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
//    @State var isPresented: Bool = false
//    @State var isPresented2: Bool = false
//
//
//    var body: some View {
//        VStack (spacing: 20) {
//            Button("Button 1") {
////                selectedModel = RandomModel(title: "Numero uno")
//                isPresented.toggle()
//            }
//            .sheet(isPresented: $isPresented) {
//                nextScreen(selectedItem: RandomModel(title: "Numero uno"))
//            }
//            Button("Button 2") {
//                //selectedModel = RandomModel(title: "Numero secundo")
//                isPresented2.toggle()
//            }
//            .sheet(isPresented: $isPresented2) {
//                nextScreen(selectedItem: RandomModel(title: "Numero secundo"))
//            }
//        }
//
//    }
//}
//struct nextScreen: View {
//
//    let selectedItem: RandomModel
//
//    var body: some View {
//        VStack {
//            Text(selectedItem.title)
//            Text(selectedItem.id)
//        }
//        .font(.title)
//    }
//}

/// MARK: APPROACH 3
// This is the best solution so far
// Because of scalability
struct MultipleSheets7: View {
    
    @State var selectedModel: RandomModel? = nil
    
    
    var body: some View {
        VStack (spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "Numero uno")
            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "Numero secundo")
            }
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedItem: model)
        }
        
    }
}
struct NextScreen: View {
    
    let selectedItem: RandomModel
    
    var body: some View {
        VStack {
            Text(selectedItem.title)
                .font(.title)
        }
        
    }
}



/// MARK: PROBLEMATIC WAY
//struct MultipleSheets7: View {
//
//    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
//    @State var isPresented: Bool = false
//
//    var body: some View {
//        VStack (spacing: 20) {
//            Button("Button 1") {
//                selectedModel = RandomModel(title: "Numero uno")
//                isPresented.toggle()
//            }
//            Button("Button 2") {
//                selectedModel = RandomModel(title: "Numero secundo")
//                isPresented.toggle()
//            }
//        }
//        .sheet(isPresented: $isPresented) {
//            nextScreen(selectedItem: selectedModel)
//        }
//    }
//}
//struct nextScreen: View {
//
//    @State var selectedItem: RandomModel
//
//    var body: some View {
//        VStack {
//            Text(selectedItem.title)
//            Text(selectedItem.id)
//        }
//        .font(.title)
//    }
//}


struct MultipleSheets7_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheets7()
    }
}
