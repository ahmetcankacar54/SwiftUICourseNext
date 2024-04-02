//
//  DeownloadEscaping22.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 2.04.2024.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class DownloadEscapingViewModel: ObservableObject {
    
    @Published var postList: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromUrl: url) { returnedData in
            
            if let data = returnedData {
                
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
                DispatchQueue.main.async { [weak self] in
                    self?.postList = newPosts
                }
            } else {
                print("No Data Returned.")
                
            }
        }
        
        
    }
    
    
// This is our generic data handler we can use through our app !!!
    func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 &&  response.statusCode < 300 else {
                
                print("Error Downloading Data!")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
}

struct DownloadEscaping22: View {
    
    @StateObject var vm = DownloadEscapingViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(vm.postList) { post in
                    VStack (spacing: 20) {
                        HStack {
                            Text("The User: \(post.userId)")
                            Spacer()
                            Text("The Post Number: \(post.id)")
                        }
                        .padding(.horizontal)
                        
                        
                        Text(post.title)
                            .font(.title2)
                        Text(post.body)
                            .font(.body)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding()
                    .shadow(radius: 20)
                    
                    
                    
                }
            }
        }
    }
}

struct DownloadEscaping22_Previews: PreviewProvider {
    static var previews: some View {
        DownloadEscaping22()
    }
}
