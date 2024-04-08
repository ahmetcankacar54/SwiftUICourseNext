//
//  NSCache27.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 8.04.2024.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager()
    
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // Maximum item in the cache
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 mb (1024 byte * 1024 byte) = 1 MegaByte , 1 MB * 100 => 100 MB
        return cache
    }()
    
    func add (image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Image Added To the Cache!")
    }
    
    func remove (name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Image Deleted from the Cache!")
    }
    
    func getImage(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}

class NSCacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    let imageName: String = "profile"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func addImageToCache() {
        guard let startingImage = startingImage else { return }
        manager.add(image: startingImage, name: imageName)
    }
    
    func removeImageFromCache() {
        manager.remove(name: imageName)
    }
    
    func getImageFromCache() {
        cachedImage = manager.getImage(name: imageName)
    }
}

struct NSCache27: View {
    
    @StateObject var vm = NSCacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipped()
                        .cornerRadius(20)
                }
                
                HStack {
                    Button {
                        vm.addImageToCache()
                    } label: {
                        Text("Save to Cache")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.removeImageFromCache()
                    } label: {
                        Text("Delete the Cache")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                        
                    }
                    
                }
                VStack {
                    Button {
                        vm.getImageFromCache()
                    } label: {
                        Text("Get From Cache")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.green)
                            .cornerRadius(10)
                        
                    }
                    if let image = vm.cachedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                            .cornerRadius(20)
                    }
                }

                Spacer()
            }
        }
    }
}

struct NSCache27_Previews: PreviewProvider {
    static var previews: some View {
        NSCache27()
    }
}
