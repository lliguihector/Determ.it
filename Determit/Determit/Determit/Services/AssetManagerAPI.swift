//
//  AssetManagerAPI.swift
//  Determit
//
//  Created by Blanca Tixi on 5/4/24.
//

import Foundation

import Foundation


struct AssetManagerAPI{
    
//CREATE
//    func createUser(_ newUserToSave: APIDevice, completion: @escaping(Result<APIErrors>)-> Void){
     //   func createDevice<T:Codable>(url: URL?, expecting: T.Type, completion:
//                                            @escaping(Result<T,APIErrors>) -> Void){
//
//
//        //URL STRING ERROR!
//        guard let url = url else{
//            completion(.failure(.invalidURL))
//            return
//        }
//
//
//        //URL Request with a specific url
//        var request = URLRequest(url: url)
//        //Set the httpmethod to a POST request
//        request.httpMethod = "POST"
//        //Set body to send JSON data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//        do {
//                   let encoder = JSONEncoder()
//                   let jsonData = try encoder.encode(T)
//                   request.httpBody = jsonData
//               } catch {
//                   print("Error encoding device data: \(error)")
//                   completion(.failure(.jsonDecodingFailed))
//                   return
//               }
//
//
//
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                   // Handle errors and parse the response...
//
//                   // Your response handling code here
//
//               }
//
//
//        dataTask.resume()
//
//    }

    
    // CREATE
        func createAsset<T: Codable>(url: URL?, assetData: T, completion: @escaping (Result<String, APIErrors>) -> Void) {
            
            // URL STRING ERROR!
            guard let url = url else {
                completion(.failure(.invalidURL))  // Provide nil or a default URL here
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(assetData)
                request.httpBody = jsonData
            } catch {
                print("Error encoding asset data: \(error)")
                completion(.failure(.jsonDecodingFailed))
                return
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Handle errors and parse the response...
                if let error = error{
                    print("Error making POST request: \(error)")
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
                if let safeData = data, let stringData = String(data: safeData, encoding: . utf8){
                    completion(.success(stringData))
                }else{
                    
                    completion(.failure(.jsonDecodingFailed))
                }
        
                
            }
            dataTask.resume()
            
            }
        
  
    
    
    
    
//READ_ALL
func getAssets<T:Codable>(url: URL?, expecting: T.Type, completion:
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
                print("From: Asset Manager Error: jsonDecodingFailed \(error)")
                completion(.failure(.jsonDecodingFailed))
                return
            }
            
        }
        
    }
    dataTask.resume()
    
    }
}
    
    
    //READ_BY_ID
    
    
    //UPDATE
    
    
    //DELETE
