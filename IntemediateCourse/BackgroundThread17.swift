//
//  BackgroundThread17.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 28.03.2024.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Check Main thread 1: \(Thread.isMainThread)")
            print("Check Main thread 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check Main thread 2: \(Thread.isMainThread)")
                print("Check Main thread 2: \(Thread.current)")
            }
            
        }
        
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
        }
        
        return data
    }
}

struct BackgroundThread17: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Load Data")
                    .font(.title)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct BackgroundThread17_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThread17()
    }
}
