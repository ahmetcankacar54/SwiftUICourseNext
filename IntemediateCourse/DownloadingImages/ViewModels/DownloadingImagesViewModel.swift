//
//  DownloadingImagesViewModel.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 8.04.2024.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$dataArray
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
    
}
