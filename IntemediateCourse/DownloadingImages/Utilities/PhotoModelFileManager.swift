//
//  PhotoModelFileManager.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 8.04.2024.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true)
                print("Folder Successfully Created!")
            } catch let error {
                print("Error Creating Folder \(error)")
            }
            
        }
    }
    
    private func getFolderPath() -> URL? {
        
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent( folderName, conformingTo: .folder)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let path = getFolderPath()
             else {
                return nil
            }
        
        return path.appendingPathComponent(key, conformingTo: .png)
    }
    
    
    func add(key: String, value: UIImage) {
        
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key)
        else {
            print("Error Saving Data!")
            return
        }
        
        do {
            try data.write(to: url)
            print(url)
        } catch {
            print("Error Writing data into file!")
        }
    }
    
    func get(key: String) -> UIImage? {
        
        guard let url = getImagePath(key: key)?.path(),
           FileManager.default.fileExists(atPath: url) else {
            print("Error Getting Image Path!")
            return nil
        }
        
        return UIImage(contentsOfFile: url)
    }
}
