//
//  SubCatExamItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 22/04/2026.
//

import SwiftUI

struct SubCatExamItemView: View {
    
    @Binding var subCatExam: SubCatExams
    let catData: CatData
    @State var imageUrl: String?
    
    init(subCatExam: SubCatExams, catData: CatData) {
        self.subCatExam = subCatExam
        self.catData = catData
        self.imageUrl = catData.image
    }
    
   
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                LoadImageView(url: $imageUrl, width: 56 , height: 56)
                    .padding(.trailing, 10)
                
                Spacer()
                
                Text(subCatExam.data.item)
                    .font(AppFont.semi_bold(18))
                
                Spacer()
                
                
                ZStack{
                    if(subCatExam.isChecked){
                        Image("check")
                    }else{
                        Image("uncheck")
                    }
                }.padding(.leading, 10)
                
                
                
               
                
            }.padding(.top,15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            
        }.frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
        
    }
}




#Preview {
    SubCatExamItemViewPreveiwWrapper()
}


struct SubCatExamItemViewPreveiwWrapper: View {
    
    @State private var subCatExam: SubCatExams
    let catData: CatData
    
    
    init(){
        
        let ex = Exam(cbtId: "2", subcatId: "4", numQuestions: 4, price: 500, title: "Map", instruction: "Wao", description: "Meet them", duration: 9, isActive: true, createdAt: "", sellerEmail: "qapp", hasSample: true, examId: "e", isProvisioned: true, numViews: 4, isMaxAttempt: true, startTime: "trie", isCompulsory: "1")
        
        var examList: [Exam] { [ex, ex, ex, ex] }
        
        var subCategoryData = SubCategoryData(
            cbtId: "",
            item: "Bag",
            createdAt: "",
            isActive: true,
            subcatId: "",
            exams: examList
        )
        
        _subCatExam = State(initialValue: SubCatExams(data: subCategoryData))
    
        
        catData = CatData(cbtId: "", subcat: [], isActive: true, createdAt: "", maxExams: 3, examType: "Year", subcatType: "Subject", image: "", maxAttempt: 1, disablePractice: true, disableReview: true, hasObjective: true, hasTheory: false, isMock: true, minimumPurchase: 500, mockDescription: "", startDate: nil, endTime: "", startTime: "", mockParent: nil, prizeMoney: 500, sponsor: Sponsor(id: "", name: "Emmanuel", website: "",  facebook: nil, instagram: nil, twitter: nil, tiktok: nil, linkedin : nil, createdAt : "", sponsorImage :nil))
                                                                                                 
                                                                                                                                                                                                                                                                                                                                                            }
    
    
    var body: some View {
        
        
        
        SubCatExamItemView()
    }
    
}
