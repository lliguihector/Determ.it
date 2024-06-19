//
//  TicketManagerAPI.swift
//  Determit
//
//  Created by Blanca Tixi on 5/20/24.
//

import Foundation



//Protocal


struct APIManager: APIManagerProtocol{
  
    static let shared = APIManager()

    private init() {}
    

    
    //MARK: -- authenticate Fiere Base token with back end server
    
    
    func authenticateWithBackEnd(idToken: String, completion:  @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/users/authenticate") else { return }
              
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
              request.addValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
              
              let task = URLSession.shared.dataTask(with: request) { data, response, error in
                  if let error = error {
                      completion(.failure(error))
                      return
                  }
                  
                  guard let data = data else { return }
                  
                  do {
                      if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          
                          let role = json["role"] as? String{
                          completion(.success(role))
                      }else{
                          
                    //Handle the error
                          }
                  } catch let error {
                      completion(.failure(error))
                  }
              }
              task.resume()
    }
    
    
    
//MARK: -- CREATE
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
    
    
    //MARK: -- READ ALL
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
        
        
        
        
        

    
    
    //MARK: -- READ BY ID
    
    
    
    
    //MARK: -- UPDATE BY ID 
    
    
    
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

