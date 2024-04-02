//
//  Typealias19.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 28.03.2024.
//

import SwiftUI

struct MoviewModel {
    let title: String
    let director: String
    let count: Int
}

// New Name for existing type. Used rarely
typealias TVModel = MoviewModel


struct Typealias19: View {
    
    @State var item: MoviewModel = MoviewModel(title: "Interstellar", director: "Christopher Nolan", count: 10000000)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct Typealias19_Previews: PreviewProvider {
    static var previews: some View {
        Typealias19()
    }
}
