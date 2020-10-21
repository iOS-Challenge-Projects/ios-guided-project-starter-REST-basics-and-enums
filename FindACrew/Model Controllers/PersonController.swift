//
//  PersonController.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class PersonController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    var people:[Person] = []
    
    //1.Base URL
    private let baseURL = URL(string: "https://lambdaswapi.herokuapp.com")!
    
    //2.Add extension to the baseURL (read documentations)
    private lazy var peopleURL = URL(string: "/api/people", relativeTo: baseURL)!
    
    
    //Fetching data functions
    func searchForPeople(searchTerm: String, completion: @escaping () -> Void) {
        
        
        //Create a component to build a query url using the base url
        var urlComponents = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
        
        //create a query item
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        //Add it to the component = "https://lambdaswapi.herokuapp.com?search:anyname"
        urlComponents?.queryItems = [searchTermQueryItem]
        
        //Unwrap url
        guard let requestURL = urlComponents?.url else {
            print("Request URL nil")
            completion()//Call completion to let user know of an error
            return
        }
        
        //HTTP request type
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //Data task
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            //Check if there is an error
            if let error = error {
                print("Error fetching data:  \(error)")
                completion()
                return
            }
        
            guard let self = self else {
                return
            }
            
            guard let data = data else{
                print("No data")
                completion()
                return
            }
            
            
            //At this point we know we have data so we will decode it into our model
            let jsonDecoder = JSONDecoder()
            
            do{
                let personSearch = try jsonDecoder.decode(PersonSearch.self, from: data)
                self.people.append(contentsOf: personSearch.results)
            }catch{
                print("Error decoding data \(error)")
                completion()
            }
            //At this point everything worked so we can access the person array 
            completion()
            
        
            
        }.resume()
        
        
        
    }
}
