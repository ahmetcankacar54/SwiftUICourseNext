//
//  DownloadWithCombine23.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 3.04.2024.
//

import SwiftUI
import Combine


struct PostModel2: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombine23ViewModel: ObservableObject {
    
    @Published var postList: [PostModel2] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        //        .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel2].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.postList = returnedPosts
            })
        // Alternatively way of using sink method with replace error method
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finished!")
//                case .failure(let error):
//                    print("error : \(error)")
//                }
//            } receiveValue: { [weak self] returnedPosts in
//                self?.postList = returnedPosts
//            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 &&  response.statusCode < 300 else {
            
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine23: View {
    
    @StateObject var vm = DownloadWithCombine23ViewModel()
    
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

struct DownloadWithCombine23_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine23()
    }
}
