//
//  APITicket.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/15/24.
//

import Foundation
import SwiftUI

struct APITicket: Hashable, Codable, Identifiable {
    
    
     var id: String { _id} //Using the '_id' as the identifier
    
    
      let _id: String //use '_id' as the identifier for Swift UI List
      let organizationId: String
      let assetId: String
      let title: String
      let description: String
      let priority: String
      let status: String
      let category: String
      let assignedTo: String
      let createdBy: String
      let createdAt: Date
      let updatedAt: Date
      let dueDate: Date
   

  }

