//
//  Model.swift
//  FoundationModelsExample2Persistance
//
//  Created by Quanpeng Yang on 3/5/26.
//

import SwiftUI
import FoundationModels
import Observation

@Observable
class ApplicationData {
    var response: AttributedString = ""
    var prompt: String = ""
    
    @ObservationIgnored var session = LanguageModelSession()
    
    static let shared: ApplicationData = ApplicationData()
    
    private init() { }
    
    func sendPrompt() async {
        do {
            let answer = try await session.respond(to: prompt)
            
            // Add response to chat box
            var newResponse = AttributedString("\(answer.content)\n\n")
            newResponse.font = .system(size: 16, weight: .regular)
            response.append(newResponse)
        } catch {
            response.append(AttributedString("Error accessing the model: \(error)\n\n"))
        }
        
        prompt = ""
    }
}
