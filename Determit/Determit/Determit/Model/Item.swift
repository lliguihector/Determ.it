//
//  Item.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import Foundation


struct Hardware{
    
    var hardwareId: String // 001
    var device: Device //
    var location: String //School
    var assetTag: String //Addd
    var os: String //MS DOS
    var history: [Ticket]
    
    init(hardwareId: String, device:Device, location: String,assetTag: String, os: String,  history: [Ticket]){
        self.hardwareId = hardwareId
        self.device = device
        self.location = location
        self.assetTag = assetTag
        self.os = os
        self.history = history
        
    }
    
  
}

struct Device{
    var brand: String //Apple
    var modelName: String //Macbook Air
    var serialNumber: String
    var year: Int // 2022
    var storage: String //256GB
    var ram: String //8gb
    
}


struct Ticket{
    var ticketID: Int //002
    var technicianName: String // JOHN Doe
    var dateReported: Date // 05-23-23
    var hardwareId: String //
    var description: String // reimage software
    var notes:String // snsns
    var status: Status // open
    var repairDate: Date? //
    var repairType: RepairType //hardware
    var priority: Priority
}

enum Priority{
    case High
    case medium
    case low
}

enum Status {
    case Reported //red
    case Assigned //yellow
    case Completed //green
    case OnHold //orange
}

enum RepairType{
  case hardware
  case software
  case other
}


