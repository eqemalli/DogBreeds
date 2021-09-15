//
//  UserDefaults.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 15.9.21.
//
import Foundation

public class UserDefault{
    
class func getFavorites()->[String]{
    
    if UserDefaults.standard.value(forKey: "dog_breed.favorites") == nil {
      return []
    }
    let encodedCart = UserDefaults.standard.value(forKey: "dog_breed.favorites") as! Data
    let jsonDecoder = JSONDecoder()
    do {
      let favorites = try jsonDecoder.decode([String].self, from: encodedCart)
      return favorites
    }catch {
      print(error)
    }
    return []
  }

  class func setFavorites(favoriteImages: [String]){
      let jsonEncoder = JSONEncoder()
      do {
        let jsonData = try jsonEncoder.encode(favoriteImages)
        UserDefaults.standard.set(jsonData, forKey: "dog_breed.favorites")
        sync()
      } catch {
        print(error)
      }
    }
    
}
