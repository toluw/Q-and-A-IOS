//
//  BankViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import Foundation

@MainActor
class BankViewModel: ObservableObject{
    
    
    @Published var state: BanksState = .loading
    
    private let service: PaystackServiceProtocol
      
      init(service: PaystackServiceProtocol = PaystackService()) {
          self.service = service
      }
    
    
    
    func getAllBanks(){
        
        state = .loading
        
        Task{
            do{
                
                let response = try await service.getBank()
                if(response.data == nil || response.data?.isEmpty == true){
                    state = .empty
                }else{
                    state =  .loaded(response.data!)
                }
                
            }catch{
                state = .error(error.localizedDescription)
            }
        }
        
       
        
        
    }
    
    
   
    
}
