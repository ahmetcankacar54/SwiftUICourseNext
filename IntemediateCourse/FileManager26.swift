//
//  FileManager26.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 7.04.2024.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init() {
        createFolderNeeded()
    }
    
    func createFolderNeeded() {
        guard let path = getPath(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Folder Successfully Created!")
            } catch let error {
                print("Error Creating Folder \(error)")
            }
            
        }
    }
    
    func deleteFolder() {
        var path: String = getPath(folderName: folderName) ?? ""
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success Deleting Folder")
        } catch let error {
            print("Error while deleting the File! \(error)")
        }
    }
        
    func saveImage(image: UIImage, name: String) {
        
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name)
        else {
            print("Error Saving Data!")
            return
        }
        
        do {
            try data.write(to: path)
            print(path)
        } catch {
            print("Error Writing data into file!")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard let dirPath = getPathForImage(name: name)?.path(),
           FileManager.default.fileExists(atPath: dirPath) else {
            print("Error Getting Image Path!")
            return nil
        }
        
        return UIImage(contentsOfFile: dirPath)
    }
    
    
    func deleteImage(name: String) {
        
        guard let dirPath = getPathForImage(name: name)?.path(),
           FileManager.default.fileExists(atPath: dirPath) else {
            print("Error Getting Image Path!")
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: dirPath)
            print("Success Deleting Image")
        } catch let error {
            print("Error while deleting the File! \(error)")
        }
        
    }
    
    func getPath(folderName: String) -> String? {
        
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent( folderName, conformingTo: .folder)
            .path()
    }
    
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent(name, conformingTo: .jpeg) else {
                return nil
            }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var imageSaved: UIImage? = nil
    let imageName = "profile"
    let manager = LocalFileManager.instance
    
    
    init() {
        getImageFromAssetsFolder()
    }
    
    
    func saveImage() {
        
        guard let image = image else {return}
        manager.saveImage(image: image, name: imageName)
        
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }

    func getImageFromFileManager() {
        imageSaved = manager.getImage(name: imageName)
        
    }
    
    func deleteImageFromFileManager() {
        manager.deleteImage(name: imageName)
    }
    
    func deleteFolderFromFileManager() {
        manager.deleteFolder()
    }
}

struct FileManager26: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(25)
                }
                
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save to File Manager")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button {
                    vm.getImageFromFileManager()
                } label: {
                    Text("Get Image from FM")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button {
                    vm.deleteImageFromFileManager()
                } label: {
                    Text("Delete Image")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Button {
                    vm.deleteFolderFromFileManager()
                } label: {
                    Text("Delete Folder")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.red)
                        .cornerRadius(10)
                }

                Spacer()
                
                Text("The Image from the file manager: ")
                
                if let image = vm.imageSaved {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(25)
                }
            }
            .navigationTitle("File Manager.")
        }
    }
}

struct FileManager26_Previews: PreviewProvider {
    static var previews: some View {
        FileManager26()
    }
}
