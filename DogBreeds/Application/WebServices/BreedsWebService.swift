//
//  BreedsWebService.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import Combine

struct BreedsWebService {
    
    func fetchBreedList() -> AnyPublisher<BreedType, BreedsAPIError> {
        
        let url = WebServiceConstants.baseURL + WebServiceConstants.allBreedsAPI

        let breedResponsePublisher: AnyPublisher<BreedType, BreedsAPIError> = WebServiceManager.sharedService.requestAPI(url: url)
    
        return breedResponsePublisher.print("\n fetch web service")
            .eraseToAnyPublisher()
    }
    
    func fetchImagesList(breed: String) -> AnyPublisher<Images, BreedsAPIError> {
        
        let url = WebServiceConstants.baseURL + WebServiceConstants.breedImagesAPI + "\(breed)/images"

        let imagesResponsePublisher: AnyPublisher<Images, BreedsAPIError> = WebServiceManager.sharedService.requestAPI(url: url)
    
        return imagesResponsePublisher.print("\n fetch web service")
            .eraseToAnyPublisher()
    }
    
}
