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
//        ZStack{
//            Color.white
//                .cornerRadius(12)
     HStack(){
        VStack(alignment: .leading){

            Text("\(ticket.title)").font(.title3)

            HStack{
                Text("Requested:").fontWeight(.light)
                Text("\(ticket.createdAt)").fontWeight(.light)
            }
            HStack{
                Text("Due Date:").fontWeight(.light)
                Text("\(ticket.dueDate)").fontWeight(.light)
            }
            HStack{
                Text("Type:").fontWeight(.light)
                Label("Network", systemImage: "network")
                
                  }
            HStack{
                Text("Priority:").fontWeight(.light)
                priorityLabel(for: ticket.priority)
                  }
            HStack{
                Text("Status:").fontWeight(.light)
                Text("Open").fontWeight(.light)
            }
            
            

        }
Spacer()
     }.padding()
  
            
//        }.fixedSize(horizontal: false, vertical: true)
//            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
         
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




private func typeLabel(for type: String) -> some View {
    switch type {
        
    case "Network":
        return Label("Network", systemImage: "network").foregroundColor(.black)
    case "Software":
        return Label("Software", systemImage: "exclamationmark.triangle.fill").foregroundColor(.black)
    case "Hardware":
        return Label("Hardware", systemImage: "exclamationmark.triangle.fill").foregroundColor(.black)
    case "Other":
        return Label("Other", systemImage: "exclamationmark.triangle.fill").foregroundColor(.black)
    default:
        return Label("Unknown", systemImage: "questionmark.diamond.fill").foregroundColor(.gray)
        
    }
    
    
    
}
struct TicketRow_Previews: PreviewProvider {
    static var previews: some View {
        
        
        TicketRow(ticket: tickets[2])
    }
}
