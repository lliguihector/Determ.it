//
//  TicketManagerAPI.swift
//  Determit
//
//  Created by Blanca Tixi on 5/20/24.
//

import Foundation


struct ManagerAPI{
  
    
    //need to test this on users, crate a user, delete a user, update a user
    
//MARK: -- CREATE / POST
    public func Create<T: Codable>(url: URL?, data: T, completion: @escaping (Result<String, APIErrors>) -> Void){
        
        //URL String Error!
        guard let url = url else{
            completion(.failure(.invalidURL))
            print("API Manager: invalid URL issue.")
            return}
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            request.httpBody = jsonData
            
        }catch{
            completion(.failure(.jsonDecodingFailed))
            print("API Manager: json encoding issue.")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            // Handle errors and parse the response...
            if let error = error{
                print("API Manager: http request issue: \(error)")
                completion(.failure(.requestFailed))
                return
            }
            
            //RESPONSE ERROR!
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)else{
                print("API Manager: http response issue.")
                completion(.failure(.responseFailed))
                return
            }
            
        //JSON DECODE ERROR!
            if let safeData = data, let stringData = String(data: safeData, encoding: . utf8){
                completion(.success(stringData))
            }else{
                print("API Manager: json Decoding issue.")
                completion(.failure(.jsonDecodingFailed))
            }
        }
            dataTask.resume()
        }
    
    
    //MARK: -- READ ALL / GET
    public func Read_All<T:Codable>(url: URL?, expecting: T.Type, completion: @escaping(Result<T,APIErrors>) -> Void){
        
        //URL Sting Error
        guard let url = url else{
            completion(.failure(.invalidURL))
            return
        }
        
        //Start Data Task
        let dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in

            //SERVER ERROR!
            if let error = error {
                print("API Manager: requestFailed \(error)")
                completion(.failure(.requestFailed))
                return
            }
            
            
            //RESPONSE ERROR!
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)else{
                print("API Manager: responseFailed")
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
                    print("API Manager: jsonDecodingFailed \(error)")
                    completion(.failure(.jsonDecodingFailed))
                    return
                }
                
            }
            
        }
        dataTask.resume()
        
        }
        
        
        
        
        

    
    
    //MARK: -- READ BY ID / GET
    
    
    
    
    //MARK: -- UPDATE BY ID / POST
    
    
    
    //MARK: -- DELETE BY ID
        
    public func Delete(url: URL?, completion: @escaping (Result<String, APIErrors>) -> Void){
        
        
        guard let url = url else{
            completion(.failure(.invalidURL))
            
            print("API Manager: invalid user ID/URL issue.")
            return
            
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        
        
        let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
            
            
            if let error = error{
                
                print("API Manager: http request issue: \(error)")
                completion(.failure(.requestFailed))
                return
            }
            
            //RESPONSE ERROR!
                    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                        print("API Manager: http response issue.")
                        completion(.failure(.responseFailed))
                        return
                    }
                    
                    // Successful deletion
                    completion(.success("Deleted successfully"))
            
        }
        
        dataTask.resume()
        

    }
    
}

