//
//  Hashable12.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 24.03.2024.
//

import SwiftUI

/* The main difference between Identifiable and Hashable is that conforming to Identifiable only says that your model has some unique identifier (which may be different every time you create an instance even with the same member values) whereas Hashable is a guarantee that an instance of your model will always produce the same hash value for a given set of member values. The latter is important because it allows you to use your model as the key in a dictionary as well as in SwiftUI view builders such as ForEach.
 */

struct MyCustomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct HAbleModel: Hashable {
    
    let title: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct Hashable12: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE"),
    ]
    
    let data2: [HAbleModel] = [
        HAbleModel(title: "ONE"),
        HAbleModel(title: "TWO"),
        HAbleModel(title: "THREE"),
        HAbleModel(title: "FOUR"),
        HAbleModel(title: "FIVE"),
    ]
    
    let data3: [String] = [
        "One", "Two", "Three", "Four", "Five"
    ]

    
    var body: some View {
        ScrollView {
            VStack (spacing: 30) {
                ForEach(data) { item in
                    Text(item.title)
                }
                
                ForEach(data2, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
                
                ForEach(data3, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

struct Hashable12_Previews: PreviewProvider {
    static var previews: some View {
        Hashable12()
    }
}
