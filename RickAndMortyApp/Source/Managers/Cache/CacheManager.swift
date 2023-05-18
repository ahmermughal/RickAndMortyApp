//
//  CacheManager.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit


/// The CacheManager class is a singleton class responsible for managing the caching of images. It has the following properties and methods:
/// - shared: A static constant that holds a single instance of the CacheManager class. This allows multiple parts of the application to access the same instance of the cache, ensuring that there is only one instance of the cache in memory.
/// - imageCache: An instance of NSCache that stores images, where the key is a NSString and the value is a UIImage. NSCache is a general-purpose cache class that is used to temporarily store objects in memory.
/// private init(): A private initializer that prevents the creation of additional instances of the CacheManager class. This ensures that there is only one instance of the cache in memory, as specified by the singleton pattern.
class CacheManager{
    
    /// Create a static constant shared instance of the CacheManager class.
    static let shared = CacheManager()
    
    /// Create an instance of NSCache to store images. The key is of type NSString, and the value is of type UIImage.
    let imageCache = NSCache<NSString, UIImage>()
    
    /// Declare a private initializer to prevent creating additional instances of the CacheManager class.
    private init(){}
    
}
