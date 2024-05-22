//
//  TicketList.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/15/24.
//

import SwiftUI

struct TicketList: View {
    var body: some View {
        
        
        List(tickets){ ticket in
            TicketRow(ticket: ticket)
            
        }
    }
}

struct TicketList_Previews: PreviewProvider {
    static var previews: some View {
        TicketList()
    }
}
