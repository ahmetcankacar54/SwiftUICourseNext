//
//  Arrays13.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 24.03.2024.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationVieModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        
        
        
        
        // sort
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
//
//        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
        
        
        // filter
//        filteredArray = dataArray.filter({ user in
//            return user.points > 30
//        })
//
//        filteredArray = dataArray.filter({ $0.points > 30 })
        
        // map
//        mappedArray = dataArray.map({ user  in
//            return user.name
//        })
//
//        mappedArray = dataArray.map({ $0.name })
        
//        mappedArray = dataArray.compactMap({ user in
//            return user.name
//        })
//
//        mappedArray = dataArray.compactMap({ $0.name })
        
        
        mappedArray = dataArray
                        .sorted(by: { $0.points > $1.points})
                        .filter({ $0.isVerified })
                        .compactMap({ $0.name })
        
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Ahmet Can", points: 8, isVerified: true)
        let user2 = UserModel(name: "Ismail", points: 0, isVerified: false)
        let user3 = UserModel(name: nil, points: 20, isVerified: true)
        let user4 = UserModel(name: "Semih", points: 40, isVerified: false)
        let user5 = UserModel(name: "Kemal", points: 43, isVerified: false)
        let user6 = UserModel(name: nil, points: 89, isVerified: true)
        let user7 = UserModel(name: "Abdullah", points: 29, isVerified: false)
        let user8 = UserModel(name: "Abuzer", points: 18, isVerified: true)
        let user9 = UserModel(name: "Ekrem", points: 32, isVerified: false)
        let user10 = UserModel(name: "Kerem", points: 67, isVerified: true)
        
        self.dataArray.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10])
    }
    
}

struct Arrays13: View {
    
    @StateObject var vm = ArrayModificationVieModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack (alignment: .leading) {
//                        Text("\(user.name)")
//                        HStack(spacing: 20) {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "checkmark.seal.fill")
//                            } else {
//                                Image(systemName: "seal")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.mint.cornerRadius(20))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct Arrays13_Previews: PreviewProvider {
    static var previews: some View {
        Arrays13()
    }
}
