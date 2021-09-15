//
//  BreedsViewModel.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import UIKit
import Combine

class BreedsViewModel {
        
    private var allBreeds = [String]()
    var tableDataSource: [BreedCellModel] = [BreedCellModel]()
    var coordinator: BreedsCoordinator
    
    private var subscriptions = Set<AnyCancellable>()
    var reloadBreedList: AnyPublisher<Result<Void, BreedsAPIError>, Never> {
        reloadBreedListSubject.eraseToAnyPublisher()
    }
    private let reloadBreedListSubject = PassthroughSubject<Result<Void, BreedsAPIError>, Never>()
    
    
    private var loadData: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    
    // MARK: Output
    var numberOfRows: Int {
        tableDataSource.count
    }
    
    var breedChoosed: AnyPublisher<String, Never> {
        breedChoosedSubject.eraseToAnyPublisher()
    }
    
    private let breedChoosedSubject = PassthroughSubject<String, Never>()
    
    
    init(coordinator: BreedsCoordinator) {
        self.coordinator = coordinator
    }
    
    func attachViewEventListener(loadData: AnyPublisher<Void, Never>) {
        self.loadData = loadData
        self.loadData
            .setFailureType(to: BreedsAPIError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.allBreeds.removeAll()
            })
            .flatMap { _ -> AnyPublisher<BreedType, BreedsAPIError> in
                let breedWebservice = BreedsWebService()
                return breedWebservice
                    .fetchBreedList()
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.tableDataSource.removeAll()
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] breeds in
                    self?.allBreeds.append(contentsOf: breeds.message.keys)
                    self?.prepareTableDataSource()
                    self?.reloadBreedListSubject.send(.success(()))
                  })
            .store(in: &subscriptions)
    }
    
    /// Prepare the tableDataSource
    private func prepareTableDataSource() {
        tableDataSource.append(contentsOf: cellTypeForPlaces())
    }
    
    
    private func cellTypeForPlaces()->[BreedCellModel] {
        var dogBreeds = [BreedCellModel]()
        let sortedBreeds = allBreeds.sorted()
        for breed in sortedBreeds {
            
            let breedCellModel = BreedCellModel(title: breed.capitalizingFirstLetter(), didTap: nil)
            
            dogBreeds.append(breedCellModel)
        }
        return  dogBreeds
    }
    
}
