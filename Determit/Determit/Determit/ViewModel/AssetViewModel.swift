//
//  AssetViewModel.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/8/24.
//

import Foundation
import CoreData
import UIKit



class AssetViewModel{
    
  
    //MARK: - Properties

    
    //API
    private let assetManager = AssetManagerAPI()
    //Create an empty array to hold the values loaded from api call
    var assets:[APIAsset] = []
    //This closure willbe called when data is succesfull update.
    var onError: ((String) -> Void)?
    var onSuccess:((String) ->Void)?
    //This error closure is used to handle and display errors
    var onDataUpdated: (() -> Void)?
    //Create an empty array to hold Core Data Device entety
    var assetsCoreData: [Asset] = []
    let assetcoreDataManager = AssetCoreDataManager.shared

    //MARK: - API METHODS
    //CREATE
    func createData(_ newAsset: APIAsset){
        assetManager.createAsset(url: constant.POST_ASSET, assetData: newAsset) { [weak self] result in
            switch result{
            case .success(let apiStringResponse):
                print("\(apiStringResponse)")
                
    
                self?.apiStringResponse(apiStringResponse)
                
                
            case.failure(let error):
                
                self?.handleError(error)
            }
        }
    }
    
    
    //READ_ALL
    func fetchData(){
        assetManager.getAssets(url: constant.GET_ALL_ASSETS, expecting: [APIAsset].self)
        {[weak self] result in
            
            switch result{
                
            case .success(let assets):
                
                
                
//                DispatchQueue.main.async{
                    
                //Store the API array Data in an array named assets
                self?.assets = assets
                //Delete All Data From Core Data
                self?.assetcoreDataManager.deleteAllAssets()
                //Write API Data to Core Data
                self?.saveAssetsToCoreData()
                
                //The UI Update should happen in the main thread
                
                DispatchQueue.main.async{
                    self?.onDataUpdated?()
                }
                
            case.failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    
    
 //MARK: -  CoreData METHODS
    
    
    //CREATE
    private func  saveAssetsToCoreData(){
        for asset in assets{
            let newAsset = asset
            assetcoreDataManager.CreateAsset(newAsset)
        }
    }
    
    //READ_ALL
    public func readAllAssetsFromCoreData(){
        assetsCoreData = assetcoreDataManager.readAllAssets()
    }
    
    
    
    //Custome Search
    
    public func queryAssetData(_ searcBarString: String){
        
        
        
      assetsCoreData = assetcoreDataManager.customeSearch(searcBarString)
        
        
        
        
    }
    
    
//MARK: - Helper Methods
private func handleError(_ error: APIErrors){
    
    let errorMessage: String
           switch error {
           case .requestFailed:
               errorMessage = "Unable to establish a network connection with the server. Please check your internet connection and try again later."
           case .responseFailed:
               errorMessage = "Response Failed"
           case .jsonDecodingFailed:
               errorMessage = "JSON Decoding Failed"
           case .invalidURL:
               errorMessage = "Invalid URL"
           case .invalidImageURL:
               errorMessage = "Invalid Image URL"
           }
    
    //Update the UI on Main thread
           DispatchQueue.main.async {
               self.onError?(errorMessage)
           }
    
    }
    
    private func apiStringResponse(_ apiStringResponse: String){
        
        
        let apiMessage = apiStringResponse
        
     
        
        
        
        //Update the UI on Main thread
               DispatchQueue.main.async {
                  
                   self.onSuccess?(apiMessage)
                   
                   
               }
    }

    
}
        
