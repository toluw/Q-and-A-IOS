//
//  CbtService.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import Foundation

protocol CbtServiceProtocol {
    
    func getParentCategories(level: String?, cbcId: String?, isActive: String, isMock: String) async throws -> ParentCategoriesResponse
    func getSubCatExams(cbtId: String, buyerEmail: String?) async throws -> SubCatExamsResponse
    func getMultipleExams(multipleExamBody: MultipleExamsBody) async throws -> MultipleExamsResponse
    func postTransaction(postTransactionBody: PostTransactionBody) async throws -> GeneralResponse
    func getCatExams(cbtId: String, buyerEmail: String?) async throws -> CatExamsResponse
    func getCbtQuestions(examId: String, buyerEmail: String) async throws -> ExamQuestionsResponse
    func postResult(examResultBody: ExamResultBody) async throws -> GeneralResponse
    func postUnfinishedResult(unfinishedResultBody: UnfinishedResultBody) async throws -> GeneralResponse
    func askAiCbt(askAiCbtBody: AskAiCbtBody) async throws -> AskAiCbtResponse
    func getNumPost(examId: String, questionId: String) async throws -> NumPostResponse
    func getCbtHistory(buyerEmail: String, isCompleted: String, page: String) async throws -> CbtHistoryResponse
    
    
    
}


final class CbtService: CbtServiceProtocol{
   
   
    private let apiClient = APIClient<CbtAPI>()
    
    func getParentCategories(level: String?, cbcId: String?, isActive: String, isMock: String) async throws -> ParentCategoriesResponse {
        return try await apiClient.request(
            .getParentCategories(level: level, cbcId: cbcId, isActive: isActive, isMock: isMock, deviceId: DeviceManager.shared.getDeviceId(), buyerEmail: UserSettings.email ?? ""),
            responseType: ParentCategoriesResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
   
    
    func getSubCatExams(cbtId: String, buyerEmail: String?) async throws -> SubCatExamsResponse {
        return try await apiClient.request(
            .getSubCatExams(cbtId: cbtId, buyerEmail: buyerEmail, deviceId: DeviceManager.shared.getDeviceId(),),
            responseType: SubCatExamsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    func getNumPost(examId: String, questionId: String) async throws -> NumPostResponse {
        return try await apiClient.request(
            .getNumPost(examId: examId, questionId: questionId),
            responseType: NumPostResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    func getCbtHistory(buyerEmail: String, isCompleted: String, page: String) async throws -> CbtHistoryResponse {
        return try await apiClient.request(
            .getCbtHistory(buyerEmail: buyerEmail, isCompleted: isCompleted, page: page),
            responseType: CbtHistoryResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    
    func getCatExams(cbtId: String, buyerEmail: String?) async throws -> CatExamsResponse {
        return try await apiClient.request(
            .getCatExams(cbtId: cbtId, buyerEmail: buyerEmail, deviceId: DeviceManager.shared.getDeviceId(),),
            responseType: CatExamsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    func getCbtQuestions(examId: String, buyerEmail: String) async throws -> ExamQuestionsResponse {
        return try await apiClient.request(
            .getCbtQuestions(examId: examId, buyerEmail: buyerEmail),
            responseType: ExamQuestionsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    func getMultipleExams(multipleExamBody: MultipleExamsBody) async throws -> MultipleExamsResponse {
        return try await apiClient.request(
            .getMultipleExams(multipleExamBody: multipleExamBody),
            responseType: MultipleExamsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
   
    
    func postResult(examResultBody: ExamResultBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .postResult(examResultBody: examResultBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        );
    }
    
    func askAiCbt(askAiCbtBody: AskAiCbtBody) async throws -> AskAiCbtResponse {
        return try await apiClient.request(.askAiCbt(askAiCbtBody: askAiCbtBody), responseType: AskAiCbtResponse.self, errorParser: {data in
            data.jsonString(forKey: "message") ?? "An error occured"
        })
    }
    
    func postUnfinishedResult(unfinishedResultBody: UnfinishedResultBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .postUnFinishedResult(unFinishedResultBody: unfinishedResultBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        );
    }
    
   
    
    
    func postTransaction(postTransactionBody: PostTransactionBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .postTransaction(postTransactionBody: postTransactionBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        );
    }
    
    
    
    
    
}


