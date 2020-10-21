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
    
    //2.Add directory base on documentations
    private lazy var peopleURL = URL(string: "/api/people", relativeTo: baseURL)!
    
    
    //Request data functions
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
        
        
    }
}
