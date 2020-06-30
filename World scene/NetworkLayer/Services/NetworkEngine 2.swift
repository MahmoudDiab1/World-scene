//
//  NetworkEngine.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

//MARK:- Responsbility : Network engine responsible for fetching data from any resource and decode it .It takes parameter of type End point to build the url request customized for a spesific resource. -


class NetworkEngine {
    
    //MARK:- get all data of any resource based on the end point (resource).
    // 1- get all news from (get all) endpoint , decode the full modle and return data decoded into decodable
    //       or error by completion.
    // 2- get all sources from (sources) endpoint.
    // 3- get all headlines from (Top headlines) endpoint.
    
    
    class func fetchData <T:Decodable>(serviceEndPoint:Endpoint, completion: @escaping( Result<T,APIError>)->Void )
    {
        var components = URLComponents()
        components.scheme=serviceEndPoint.scheme
        components.host=serviceEndPoint.base
        components.path=serviceEndPoint.path
        components.queryItems=serviceEndPoint.parameter
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod=serviceEndPoint.method
        print(request)
        
        let session = URLSession(configuration: .default)
        let task =  session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {  completion(.failure(.responseUnsuccessful(description: error?.localizedDescription))); return}
            guard error == nil else { completion(.failure(.errorValue(description: error?.localizedDescription))) ; return}
            guard let data = data else { completion(.failure((.badDataResponse(description: error?.localizedDescription)))) ; return}
            
            DispatchQueue.main.async {
                do {
                    guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
                        else {
                            throw NSError.init(domain: "decode", code: 1 )
                    }
                    completion(.success(decodedData))
                } catch {
                    (completion(.failure(.decodingTaskFailure(description: error.localizedDescription))))
                }
            }
        }
        task.resume()
    }
    
}
