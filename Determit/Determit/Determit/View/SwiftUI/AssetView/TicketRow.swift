//
//  AssetView.swift
//  Determit
//
//  Created by Blanca Tixi on 5/4/24.
//

import SwiftUI
import MapKit

struct TicketRow: View {

   
  
    var ticket: APITicket
    
    var body: some View {
     
        HStack(){
            

            VStack(alignment: .leading){
                
                //Ticket Title
                Text("\(ticket.title)").font(.title)
                
                //Ticket Requested Date
                HStack{
                    Text("Requested:").fontWeight(.light)
                    Text("\(ticket.createdAt)")
                }
              
                HStack{
                    Text("Due Date:").fontWeight(.light)
                    Text("\(ticket.dueDate)")
                }
           
                
                
                
                //Display the Priority of the ticket Red = high, yellow = medium, greern = low
                                        VStack{
                                            
                                            
                                            HStack{
                                                Text("Priority:").fontWeight(.light)
                                                priorityLabel(for: ticket.priority)
                                                HStack{
                                                    Text("Status:").fontWeight(.light)
                                                    Text("Open")
                                                      
                                                }
                                            }
                                            
                                           
                                       
                                        
                                    }
                
                
                
                
            }
Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        
    }
}


// Function to determine the color label based on the priority
    private func priorityLabel(for priority: String) -> some View {
        switch priority {
            case "High":
                return Label("High", systemImage: "exclamationmark.triangle.fill").foregroundColor(.red)
            case "Medium":
                return Label("Medium", systemImage: "exclamationmark.triangle.fill").foregroundColor(.yellow)
            case "Low":
                return Label("Low", systemImage: "exclamationmark.triangle.fill").foregroundColor(.green)
            default:
                return Label("Unknown", systemImage: "questionmark.diamond.fill").foregroundColor(.gray)
        }
    }

struct AssetView_Previews: PreviewProvider {
    static var previews: some View {


     
        TicketRow(ticket: tickets[0])
        
        
    }
}
