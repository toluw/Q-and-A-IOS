//
//  CbtHistoryViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 18/08/2026.
//

import Foundation

@MainActor
class CbtHistoryViewModel: ObservableObject {
    
    
    
    @Published var state = CbtHistoryState()
    
    var cbtHistory: CbtHistory? = nil
    

    private let service: CbtServiceProtocol
    
    
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    /// Call once, e.g. from `.task` on first appearance.
    func loadInitial() async {
        guard state.items.isEmpty else { return }
        await fetch(page: 1)
    }
    
    
    /// Pull-to-refresh, and also used to retry a failed initial load.
    func refresh() async {
        await fetch(page: 1)
    }

    /// Triggered automatically as the user scrolls near the end of the list.
    func loadMoreIfNeeded(currentItem: CbtHistory) async {
        guard let last = state.items.last, last.id == currentItem.id else { return }
        await loadMore()
    }

    /// Also callable directly from a "Retry" button in the footer.
    func loadMore() async {
        guard !state.isLoading, !state.isLoadingMore else { return }
        guard state.hasMorePages else { return }
        await fetch(page: state.currentPage + 1)
    }
    
    
    
    private func fetch(page: Int) async{
        
        let isLoadMore = page > 1

        if isLoadMore {
            state.isLoadingMore = true
            state.loadMoreErrorMessage = nil
        } else {
            state.isLoading = true
            state.errorMessage = nil
        }
        
        do {
           
            
            let response = try await service.getCbtHistory(buyerEmail: UserSettings.email ?? "", isCompleted: "1", page: String(page))

            state.currentPage = response.data.page
            state.totalPages = response.data.total_pages

            if isLoadMore {
                state.items.append(contentsOf: response.data.items)
            } else {
                state.items = response.data.items
            }

            state.isLoading = false
            state.isLoadingMore = false

        } catch {
            if isLoadMore {
                state.isLoadingMore = false
                state.loadMoreErrorMessage = error.localizedDescription
            } else {
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        }
        
        
        
        
    }
    
    func getLiveExam(resultId: String){
        state.showLoader = true
        
        Task{
            do{
              
                let response = try await service.getLiveExam(resultId: resultId)
                state.showLoader = false
                state.liveExamDataList = response.data
                
                
                
            } catch {
                state.showLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.getLiveExam(resultId: resultId)
                })
            }
        }
    }
    
    
    func getExamResultData(cbtHistory: CbtHistory, data: [LiveExamData]) -> ExamResultData{
        
        let examResult = ExamResult(item: cbtHistory.item, examId: cbtHistory.examId, numQuestions: Int(cbtHistory.numQuestions) ?? 0, shouldShuffle: cbtHistory.shouldShuffle == "1", category: cbtHistory.category, image:cbtHistory.image, examTime: Int(cbtHistory.examTime) ?? 0, score: Double(cbtHistory.score) ?? 0.0, createAt: cbtHistory.createdAt, disableReview: cbtHistory.disableReview, timeDuration: Int(cbtHistory.timeDuration) ?? 0, endTime: cbtHistory.endTime)
        
        let liveExamList: [LiveExam] = data.map { item in
            LiveExam(
                question: item.question,
                passage: item.passage,
                a: item.a,
                b: item.b,
                c: item.c,
                d: item.d,
                e: item.e,
                numberOfAnswer: Int(item.numberOfAnswer) ?? 0,
                answer: item.answer,
                explanation: item.explanation,
                questionId: item.questionId,
                questionImage: item.questionImage,
                passageImage: item.passageImage,
                aImage: item.aImage,
                bImage: item.bImage,
                cImage: item.cImage,
                dImage: item.dImage,
                eImage: item.eImage,
                explanationImage: item.explanationImage,
                solution: item.solution.convertCommaDelimitedStringToList(),
                passageVideo: item.passageVideo,
                passageBook: item.passageBook
            )
        }
        
        return ExamResultData(examResult: examResult, liveExamList: liveExamList)
        
        
    }
    
    
    
    
    
    
}
