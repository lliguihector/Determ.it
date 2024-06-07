//
//  AssetList.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/7/24.
//

import SwiftUI

struct List: View {
    
    
    var body: some View {
        List(tickets) { ticket in
           Row(ticket: ticket)
            
        }
        
    }

    
        
        
}

struct AssetList_Previews: PreviewProvider {
    static var previews: some View {
        List()
    }
}
