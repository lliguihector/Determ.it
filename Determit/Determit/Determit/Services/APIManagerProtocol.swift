//
//  APIManagerProtocol.swift
//  Determit
//
//  Created by Blanca Tixi on 6/19/24.
//

import Foundation


protocol APIManagerProtocol{
    func authenticateWithBackEnd(idToken: String, completion: @escaping (Result<String, Error>) -> Void)
     // Add other method signatures if needed
}
