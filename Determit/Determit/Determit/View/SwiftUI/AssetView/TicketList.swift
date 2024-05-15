//
//  AssetList.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/7/24.
//

import SwiftUI

struct TicketList: View {
    var body: some View {
        List(tickets) { ticket in
            TicketRow(ticket: ticket)
            
        }
    }
}

struct AssetList_Previews: PreviewProvider {
    static var previews: some View {
        TicketList()
    }
}
