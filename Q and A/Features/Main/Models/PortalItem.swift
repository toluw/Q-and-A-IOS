//
//  PortalItem.swift
//  Q and A
//
//  Created by GIGL-PC on 19/10/2026.
//

import Foundation


enum PortalItem: Equatable, Identifiable {
    
    
    var id: String {
        switch self {
        case .paymentMade: return "paymentMade"
        case .paymentRecieved: return "paymentReceived"
        case .paymentRecievedAgency: return "paymentReceivedAgency"
        case .paymentRecievedCBT: return "paymentReceivedCBT"
        case .earningsCBT: return "earningsCBT"
        case .earningsAgency: return "earningsAgency"
        }
    }
    case paymentMade(title: String, isEnabled: Bool)
    case paymentRecieved(title: String, isEnabled: Bool)
    case paymentRecievedAgency(title: String, isEnabled: Bool)
    case paymentRecievedCBT(title: String, isEnabled: Bool)
    case earningsCBT(title: String, isEnabled: Bool)
    case earningsAgency(title: String, isEnabled: Bool)
    
    
    func getTitle()-> String{
       
        switch self {
            
        case .paymentMade(title: let title, isEnabled: _):
           return title
        case .paymentRecieved(title: let title, isEnabled: _):
            return  title
        case .paymentRecievedAgency(title: let title, isEnabled: _):
            return title
        case .paymentRecievedCBT(title: let title, isEnabled: _):
            return  title
        case .earningsCBT(title: let title, isEnabled: _):
            return  title
        case .earningsAgency(title: let title, isEnabled: _):
            return  title
        }
    
        
    }
    
    func isEnabled() -> Bool {
        switch self {
            
        case .paymentMade(title: let title, isEnabled: let isEnabled):
            return  isEnabled
        case .paymentRecieved(title: let title, isEnabled: let isEnabled):
            return  isEnabled
        case .paymentRecievedAgency(title: let title, isEnabled: let isEnabled):
            return  isEnabled
        case .paymentRecievedCBT(title: let title, isEnabled: let isEnabled):
            return  isEnabled
        case .earningsCBT(title: let title, isEnabled: let isEnabled):
            return  isEnabled
        case .earningsAgency(title: let title, isEnabled: let isEnabled):
            return  isEnabled
        }
    }
    
}
    
    
    



