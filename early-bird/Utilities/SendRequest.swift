//
//  SendRequest.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/17/25.
//
import SwiftUI
import Foundation

func sendPostRequest<T: Codable>(to endPoint: String, with object: T, completion: @escaping (Result<String, Error>) -> Void) {
    let urlString = "\(Constants.BASE_URL)\(endPoint)"
    guard let url = URL(string: urlString) else {
        print("❌ 유효하지 않은 URL: \(urlString)")
        completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(object)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("📤 전송할 JSON: \(jsonString)") // JSON 출력
        }
        request.httpBody = jsonData
    } catch {
        print("❌ JSON 인코딩 실패: \(error)")
        completion(.failure(error))
    }
    
    do {
        let jsonData = try JSONEncoder().encode(object)
        request.httpBody = jsonData
        
        print("📤 Request: \(request)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ 요청 실패: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ 잘못된 응답 형식")
                completion(.failure(NSError(domain: "Invalid Response", code: 500, userInfo: nil)))
                return
            }
                
            guard let data = data else {
                print("❌ 응답 데이터 없음")
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }
                
            if httpResponse.statusCode == 200 {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("✅ 성공적인 응답: \(responseString)")
                    completion(.success(responseString))
                } else {
                    print("❌ 데이터 디코딩 실패")
                    completion(.failure(NSError(domain: "Decoding Error", code: 500, userInfo: nil)))
                }
            } else {
                // ❗ 서버에서 보낸 에러 메시지 출력
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown Error"
                print("❌ 서버 오류 (\(httpResponse.statusCode)): \(errorMessage)")
                
                let error = NSError(domain: "Server Error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                completion(.failure(error))
            }
        }.resume()
            
    } catch {
        print("❌ JSON 인코딩 실패: \(error)")
        completion(.failure(error))
    }
}

