//
//  CbtCategoryBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 15/04/2026.
//

import SwiftUI

struct CbtCategoryBottomSheetView: View {
    
    let items: [DataModel]
    let onItemClicked: (DataModel) -> Void
   
    
    var body: some View {
        
        
        VStack{
            
            DragIndicator()
            
           
            
            ScrollView(){
                
        
                LazyVStack(spacing: 0){
                    
                    Text("Select Category").font(AppFont.regular(16)).padding(.top, 30)
                     
                     ForEach(items){item in
                         ItemView(item: item.item, onItemClicked: {
                             onItemClicked(item)
                         })
                     }.padding(.top, 20)
                        
                        
                    }
                    
               
                }
            
             
            Spacer()
            
            
        }.background(.white)
        
        
            
        }
        
      
    
    
    
}


#Preview {
    let dataModel = DataModel(
        cbcId: "",
        isCat: true,
        item: "Lobby",
        isActive: true,
        isMock: "2",
        level: "1",
        catData: nil,
        createdAt: ""
    )
    
    let items = [dataModel, dataModel, dataModel]
    
    CbtCategoryBottomSheetView(items: items, onItemClicked: { data in })
    
    
}




