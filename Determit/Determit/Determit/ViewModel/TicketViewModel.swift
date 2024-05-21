//
//  TicketViewModel.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/8/24.
//

import Foundation


class TicketViewModel: ObservableObject{
    
    
    var apiManager = ManagerAPI()
    
    //ObservableObject allows objects to announce changes to their data/ will automaticaly update the ui when these properties changes
    @Published var tickets: [APITicket] = [] //API Data
    
    
  
    
    
    //Create a new ticket and send it to mongoDB
    func CreateTicket( ticketData: APITicket, completion: @escaping (Result<String, APIErrors>) -> Void) {
        
        
        apiManager.Create(url: constant.CREATE_TICKET, data: ticketData) { result in
            
            switch result{
            case .success(let message):
                           // Handle success, if needed
                           completion(.success(message))
                       case .failure(let error):
                           // Handle failure
                           completion(.failure(error))
            }
        
    }
    

    }
    
    
    //Fetch all tickets from mongoDB
    func fetchAllTickets(completion: @escaping (Result<[APITicket], APIErrors>) -> Void) {
        
        
        
        apiManager.Read_All(url: constant.GET_ALL_TICKETS, expecting: [APITicket].self){ result in
            
            switch result{
                
            case .success(let tickets):
                
                self.tickets = tickets
                completion(.success(tickets))
            
            case .failure(let error):
                completion(.failure(error))
            }
            
            
        }
        
       
        
        
        
    }
    
    
}
