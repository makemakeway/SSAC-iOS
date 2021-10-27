//
//  MovieAPIManager.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit
import Kingfisher


class MovieAPIManager {
    static let shared = MovieAPIManager()
    func fetchMovieData(dayOrWeek: DayOrWeek, category: MediaCategory, page: Int, result: @escaping (Int, JSON)->() ) {
        
        let url = "https://api.themoviedb.org/3/trending/\(category.rawValue)/\(dayOrWeek.rawValue)?api_key=\(API.THE_MOVIE_DATABASE_API)&page=\(page)"
        
        AF.request(url).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMovieImage(imageUrl: String, imageView: UIImageView) {
        let urlString = "https://image.tmdb.org/t/p/original\(imageUrl)"
        guard let url = URL(string: urlString) else { return }
        
        imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star"))
    }
}
