//
//  BreedImagesViewModel.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import UIKit
import Combine

class BreedImagesViewModel {
        
    var allImages = [String]()
    var dataSource: [ImageCellModel] = [ImageCellModel]()
    var coordinator: BreedsCoordinator
    var breed: String
    
    private var subscriptions = Set<AnyCancellable>()
    var reloadImagesList: AnyPublisher<Result<Void, BreedsAPIError>, Never> {
        reloadImagesListSubject.eraseToAnyPublisher()
    }
    private let reloadImagesListSubject = PassthroughSubject<Result<Void, BreedsAPIError>, Never>()
    
    
    private var loadData: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    
    // MARK: Output
    var numberOfItems: Int {
        dataSource.count
    }
    
    var breedChoosed: AnyPublisher<String, Never> {
        breedChoosedSubject.eraseToAnyPublisher()
    }
    
    private let breedChoosedSubject = PassthroughSubject<String, Never>()
    
    
    init(coordinator: BreedsCoordinator, breed:String) {
        self.coordinator = coordinator
        self.breed = breed
    }
    
    func attachViewEventListener(loadData: AnyPublisher<Void, Never>) {
        self.loadData = loadData
        self.loadData
            .setFailureType(to: BreedsAPIError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.allImages.removeAll()
            })
            .flatMap { [self] _ -> AnyPublisher<Images, BreedsAPIError> in
                let breedWebservice = BreedsWebService()
                return breedWebservice
                    .fetchImagesList(breed: breed.lowercased())
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.dataSource.removeAll()
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] breeds in
                    self?.allImages.append(contentsOf: breeds.message)
                    self?.prepareCollectionDataSource()
                    self?.reloadImagesListSubject.send(.success(()))
                  })
            .store(in: &subscriptions)
    }
    
    /// Prepare the CollectionDataSource
    private func prepareCollectionDataSource() {
        dataSource.append(contentsOf: dogImages())
    }
    
    
    private func dogImages()->[ImageCellModel] {
        var dogBreeds = [ImageCellModel]()
        
        for image in allImages {
            
            let imageCellModel = ImageCellModel(breedImage: image)
            
            dogBreeds.append(imageCellModel)
        }
        return  dogBreeds
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
