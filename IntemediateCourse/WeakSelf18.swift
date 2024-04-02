//
//  WeakSelf18.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 28.03.2024.
//

import SwiftUI

struct WeakSelf18: View {
    
    @AppStorage("count") var count: Int?
    
    init(count: Int? = nil) {
        self.count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate to", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.title)
                .frame(width: 50, height: 70)
                .background(Color.orange.cornerRadius(10))
        }
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSSViewModel()
    
    var body: some View {
        VStack {
            Text("View Sekando!")
                .font(.largeTitle)
                .foregroundColor(.purple)
            
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSSViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    
    init() {
        print("Initialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("deinitialize")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
        /*
         When we call a background action it will init the view but not deinit until background action done.
         So this is raise a problem which is It doesn't deinit the second screen when user get back to the main screen. it will stack on the ram until all process finished.
         The main responsible of this issue is calling self. Self persist to finished. So deinit never run until done.
         To prevent this we call [weak self] and when user leave the view process will be deprecated immediately and deinit function will be initialized.
         
         USE THIS FOR LONG AND CONSUMING TASKS
         */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) { [weak self] in
            self?.data = "New Data !"
        }
    }
}

struct WeakSelf18_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelf18()
    }
}
