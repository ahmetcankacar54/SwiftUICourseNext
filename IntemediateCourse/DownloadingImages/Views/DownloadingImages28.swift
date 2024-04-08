//
//  DownloadingImages28.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 8.04.2024.
//

import SwiftUI

struct DownloadingImages28: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                    
                }
            }
            .navigationTitle("Downloading Images!")
        }
        
    }
}

struct DownloadingImages28_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImages28()
    }
}
