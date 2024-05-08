//
//  APIAsset.swift
//  Determit
//
//  Created by Blanca Tixi on 5/3/24.
//

import Foundation
import SwiftUI

struct APIAsset: Hashable, Codable, Identifiable {
  
    
    var id: String { _id} //Using the '_id' as the identifier
    
    
    let _id: String //use '_id' as the identifier for Swift UI List
    let assetTag: String
    let deviceID: String
    let serialNumber: String
    
}
