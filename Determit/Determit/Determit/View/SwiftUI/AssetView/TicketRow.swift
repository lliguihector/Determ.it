//
//  TicketRow.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/15/24.
//

import SwiftUI

struct TicketRow: View {
    
    var ticket: APITicket
    
    
    
    var body: some View {
   
        
        
        
        ZStack{

            Color.white
                .cornerRadius(12)


     HStack(){
        
        
        VStack(alignment: .leading){
            
            //Ticket Title
            Text("\(ticket.title)").font(.title3)
            
            //Ticket Requested Date
            HStack{
                Text("Requested:").fontWeight(.light)
                Text("\(ticket.createdAt)").fontWeight(.light)
            }
          
            HStack{
                Text("Due Date:").fontWeight(.light)
                Text("\(ticket.dueDate)").fontWeight(.light)
            }
       
            
            //Display the Priority of the ticket Red = high, yellow = medium, greern = low
                                    VStack{
                                        
                                        HStack{
                                            Text("Priority:").fontWeight(.light)
                                            priorityLabel(for: ticket.priority)
                                            HStack{
                                                Text("Status:").fontWeight(.light)
                                                Text("Open").fontWeight(.light)
                                            }
                                        }
                                }

        }
Spacer()
     }.padding()
            
        }.fixedSize(horizontal: false, vertical: true)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
         
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
struct TicketRow_Previews: PreviewProvider {
    static var previews: some View {
        
        
        TicketRow(ticket: tickets[0])
    }
}
