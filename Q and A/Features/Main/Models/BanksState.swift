//
//  BanksState.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import Foundation

enum BanksState{
    
case loading
case loaded([BankData])
case error(String)
case empty
    
}
