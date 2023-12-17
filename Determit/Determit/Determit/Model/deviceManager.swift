//
//  DeviceManager.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 12/17/23.
//

import Foundation


enum APIErrors: Error{
    case requestFailed
    case responseFailed
    case jsonDecodingFailed
    case invalidURL
    
}




struct DeviceManager{
    
    
//Get all news Feed
func getNewsFeed<T:Codable>(url: URL?, expecting: T.Type, completion:
                                    @escaping(Result<T,APIErrors>) -> Void){
        
        //URL STRING ERROR!
    guard let url = url else{
        completion(.failure(.invalidURL))
        return
    }
    
    //Start Data Task
    let dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in

        //SERVER ERROR!
        if let error = error {
            print("From: News Feed Manager Erorr: requestFailed \(error)")
            completion(.failure(.requestFailed))
            return
        }
        
        
        //RESPONSE ERROR!
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)else{
            print("From: News Feed Manager Erorr: responseFailed")
            completion(.failure(.responseFailed))
            return
        }
        
    //JSON DECODE ERROR!
        if let safeData = data{
            
            
            let decoder = JSONDecoder()
            
            do{
                //DECODE JSON DATA
                let decodedData = try decoder.decode(expecting, from: safeData)
                completion(.success(decodedData))
            }catch{
                print("From: Device Manaher Error: jsonDecodingFailed \(error)")
                completion(.failure(.jsonDecodingFailed))
                return
            }
            
        }
        
    }
    dataTask.resume()
    
    }
}
