//
//  CatViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 25/05/2026.
//

import Foundation

@MainActor
class CatViewModel: ObservableObject{
    
    @Published var state: CatState = CatState()
    @Published var showQuestionSelectSheet: Bool = false
    @Published var showExamModeSheet: Bool = false
    @Published var showLogin: Bool = false
    var premExam: PremExam? = nil
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    
    func reInitExamSelection(){
        state.examSelectList = []
    }
    
    
    func getExamSelectList(category: String, image: String?, disableReview: Bool) -> [ExamSelect] {
      return  state.examSelectList.map {
            ExamSelect(
                item: "\($0.exam.title)",
                exam: $0.exam,
                numQuestions: $0.numQuestions,
                shouldShuffle: $0.shouldShuffle,
                category: category,
                image: image,
                disableReview: disableReview
            )
        }
        
        
    }
    
   
    func getInitPosition(catExams: CatExams) -> Int?{
       
        let items = state.initItems.filter { $0.exam.examId == catExams.exam.examId }
            
            guard let item = items.first else {
                return nil
            }
            
            return state.initItems.firstIndex { $0 == item }
        
    }
    
    
    func updateExamSelect(
        examId: String,
        shouldShuffle: Bool? = nil,
        numQuestion: Int? = nil,
        exam: Exam? = nil
    ) {
        state.examSelectList = state.examSelectList.map { item in
            var newItem = item
            
            guard newItem.exam.examId == examId else { return newItem }
            
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
    
    
    func getSubCatExams(cbtId: String, buyerEmail: String?){
        
            
        
        state.isLoading = true
        state.errorMessage = nil
        
        Task{
            do{
              
                let response = try await service.getCatExams(cbtId: cbtId, buyerEmail: buyerEmail)
                state.isLoading = false
                
                
                let catExams: [CatExams] = response.data.sorted { $0.isProvisioned && !$1.isProvisioned }.map{exam in
                    
                    CatExams(exam: exam)
                    
                }
                
               
                
                state.initItems = catExams
                state.items = catExams
                
                
                } catch {
                
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        }
        
    }
    
    
    
   
    
    
    
    
    
}
