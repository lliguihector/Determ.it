//
//  TicketViewModel.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/8/24.
//

import Foundation


class TicketViewModel: ObservableObject{
    //ObservableObject allows objects to announce changes to their data/ will automaticaly update the ui when these properties changes
    @Published var data: [APITicket] = [] //API Data
    
    
    var apiManager = ManagerAPI()
    
    
    func Create(_ newData: APITicket){
        
        
        
    }
    

    
    
    
    
}
