//
//  SubCatViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 18/04/2026.
//

import Foundation

@MainActor
class SubCatViewModel: ObservableObject {
    
    
    @Published var state: SubCatState = SubCatState()
    @Published var showExamSelectSheet: Bool = false
    @Published var showQuestionSelectSheet: Bool = false
    @Published var showExamModeSheet: Bool = false
    @Published var showLogin: Bool = false
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    func reInitExamSelection(){
        state.examSelectList = []
    }
    
    func getExamSelectList(category: String, image: String?) -> [ExamSelect] {
      return  state.examSelectList.map {
            ExamSelect(
                item: "\($0.item) - \($0.exam.title)",
                exam: $0.exam,
                numQuestions: $0.numQuestions,
                shouldShuffle: $0.shouldShuffle,
                category: category,
                image: image,
                disableReview: $0.disableReview
            )
        }
        
        
    }
    
    
    
    func getMultipleExam(multipleExamBody: MultipleExamsBody){
        
       
        
        state.showBlockedLoader = true
        
        Task{
            do{
              
                let response = try await service.getMultipleExams(multipleExamBody: multipleExamBody)
                state.showBlockedLoader = false
                state.multipleExamData = response.data
                
                
                
            } catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.getMultipleExam(multipleExamBody: multipleExamBody)
                })
            }
        }
        
    }
    
    
   
    
    
    func getSubCatExams(cbtId: String, buyerEmail: String?) async{
        
            
        
        state.isLoading = true
        state.errorMessage = nil
        
        
            do{
              
                let response = try await service.getSubCatExams(cbtId: cbtId, buyerEmail: buyerEmail)
                state.isLoading = false
                
                let subCatExams: [SubCatExams] = response.data.map { data1 in
                    SubCatExams(
                        data: {
                            var copied = data1
                            copied.exams = data1.exams.sorted { $0.isProvisioned && !$1.isProvisioned }
                            return copied
                        }()
                    )
                }
                
                state.initItems = subCatExams
                state.items = subCatExams
                
                
                } catch {
                
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        
        
    }
    
    func getInitPosition(subCatExams: SubCatExams) -> Int?{
       
        let items = state.initItems.filter { $0.data.subcatId == subCatExams.data.subcatId }
            
            guard let item = items.first else {
                return nil
            }
            
            return state.initItems.firstIndex { $0 == item }
        
    }
    
    func updateExamSelect(
        subCatId: String,
        shouldShuffle: Bool? = nil,
        numQuestion: Int? = nil,
        exam: Exam? = nil
    ) {
        state.examSelectList = state.examSelectList.map { item in
            var newItem = item
            
            guard newItem.subcatId == subCatId else { return newItem }
            
            if let shuffle = shouldShuffle {
                newItem.shouldShuffle = shuffle
            }
            
            if let question = numQuestion {
                newItem.numQuestions = question
            }
            
            if let ex = exam {
                newItem.exam = ex
                newItem.numQuestions = ex.numQuestions
            }
            
            return newItem
        }
    }
    
    
}
