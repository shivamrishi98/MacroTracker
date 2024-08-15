//
//  OpenAIService.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 15/8/2024.
//

import Foundation



enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

class OpenAIService {
    
    static let shared = OpenAIService()
    
    private init() {}
    
    private func generateURLRequest(httpMethod: HttpMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")
        
        let systemMessage = GPTMessage(role: "system", content: "You are a macronutrient expert.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let food = GPTFunctionProperty(type: "string", description: "The food item e.g. hamburger")
        let fats = GPTFunctionProperty(type: "integer", description: "The amount of fats in grams of the given food item")
        let carbs = GPTFunctionProperty(type: "integer", description: "The amount of carbohydrates in grams of the given food item")
        let protein = GPTFunctionProperty(type: "integer", description: "The amount of protein in grams of the given food item")
        let properties: [String : GPTFunctionProperty] = [
            "food": food,
            "fats": fats,
            "carbs": carbs,
            "protein": protein
        ]
        
        let functionParams = GPTFunctionParameter(type: "object",
                                                  properties: properties,
                                                  required: ["food", "fats", "carbs", "protein"])
        
        let function = GPTFunction(name: "get_macronutrients",
                                   description: "Get the macronutrients for the given food.",
                                   parameters: functionParams)
        
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-1106",
                                     messages: [systemMessage, userMessage],
                                     functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    func sendPromptToChatGPT(message: String) async throws {
        let urlRequest = try generateURLRequest(httpMethod: .post,
                                            message: message)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        print(String(data: data, encoding: .utf8)!)
    }
    
}
struct GPTChatPayload: Encodable {
    let model: String
    let messages: [GPTMessage]
    let functions: [GPTFunction]
}

struct GPTMessage: Encodable {
    let role: String
    let content: String
}

struct GPTFunction: Encodable {
    let name: String
    let description: String
    let parameters: GPTFunctionParameter
}

struct GPTFunctionParameter: Encodable {
    let type: String
    let properties: [String: GPTFunctionProperty]?
    let required: [String]?
}

struct GPTFunctionProperty: Encodable {
    let type: String
    let description: String
}
