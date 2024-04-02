//
//  Escaping20.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 28.03.2024.
//

import SwiftUI

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello There"
    
    
    func getData() {
        
//        downloadData2 { [weak self] returned in
//            self?.text = returned
//        }
        
        // This is more fancy and understandable way to use.
//        downloadData3 { [weak self] returnedResult in
//            self?.text = returnedResult.data
        
        downloadData4 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        
        return "New Data!"
    }
    
    // @escaping makes function async
    func downloadData2(completionHandler: @escaping (_ data: String) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New Data!")
        }
        
    }
    
    // This is more fancy and understandable way to use.
    func downloadData3(completionHandler: @escaping (DownloadResult) -> Void) {
        let result = DownloadResult(data: "New Data!")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler(result)
        }
        
    }
    
    // This is the final form for best case usage
    func downloadData4(completionHandler: @escaping DownloadCompletion) {
        let result = DownloadResult(data: "New Data!")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler(result)
        }
        
    }
    
    // The under score before the data parameter is basically external name for the parameter.
    // You can chnage the external name.
    
    /*
     func exampleFunctionCaller() {
         exampleFunction(userName: "Clark")
     }
     func exampleFunction(_ name: String) -> Void
     func exampleFunction(userName name: String) -> Void {
         
     }
     */
    
}

struct Escaping20: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.title)
            .fontWeight(.bold)
            .onTapGesture {
                vm.getData()
            }
            
    }
}

struct Escaping20_Previews: PreviewProvider {
    static var previews: some View {
        Escaping20()
    }
}
