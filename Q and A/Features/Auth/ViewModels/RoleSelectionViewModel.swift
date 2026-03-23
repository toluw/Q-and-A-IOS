//
//  RoleSelectionViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 23/03/2026.
//

import Foundation

class RoleSelectionViewModel: ObservableObject{
    
    @Published var selectedRole: UserRole = .buyer
    
    var features: [RoleFeature] {
            switch selectedRole {
            case .buyer:
                return [
                    RoleFeature(
                        icon: "resource",
                        title: "Resources",
                        description: "Get access to millions of Educational and Career resources in text, audio & video formats."
                    ),
                    RoleFeature(
                        icon: "community",
                        title: "Community",
                        description: "Participate, connect & get insight from the resources forum."
                    )
                ]
                
            case .seller:
                return [
                    RoleFeature(
                        icon: "resource",
                        title: "Share",
                        description: "Distribute Educational and Career resources in E-book format."
                    ),
                    RoleFeature(
                        icon: "media",
                        title: "Media Content",
                        description: "Distribute Educational & Career resources in audio and video formats."
                    ),
                    RoleFeature(
                        icon: "earn",
                        title: "Earn",
                        description: "Get 60% commission payment on every purchase of your material."
                    )
                ]
            }
        }
    
    
    }




    
