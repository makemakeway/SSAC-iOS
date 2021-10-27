//
//  TranslatedAPIManager.swift
//  Translate
//
//  Created by 박연배 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslatedAPIManager {
    static let shared = TranslatedAPIManager()
    
    func fetchTranslateData(text: String, result: @escaping (Int, JSON) -> () ) {
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : API.NAVER_ID,
            "X-Naver-Client-Secret" : API.NAVER_SECRET
        ]
        
        
        let params = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        AF.request(Endpoint.translatedURL, method: .post, parameters: params, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let code = response.response?.statusCode ?? 500
                result(code, json)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
