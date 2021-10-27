//
//  VisionAPIManager.swift
//  Translate
//
//  Created by 박연배 on 2021/10/27.
//

import UIKit
import SwiftyJSON
import Alamofire


class VisionAPIManager {
    static let shared = VisionAPIManager()
    
    func fetchFaceData(image: UIImage, result: @escaping (Int,JSON) -> () ) {
        let header: HTTPHeaders = [
            "Authorization" : API.KAKAO_API_KEY,
            "Content-Type" : "multipart/form-data"
        ]
        
        //UIImage를 바이너리 타입으로 변환
        guard let imageData = image.pngData() else { return }
        
        
        // Alamofire의 multipartFormData에는 헤더가 내장되어 있다. 따라서 위에 있는 헤더의 ContentType를 제거해도 정상적으로 작동한다. 그럼에도 불구하고 명확하게 작성을 해주는 것이 좋다.
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: Endpoint.visionURL, headers: header).validate(statusCode: 200...500).responseJSON { response in
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
