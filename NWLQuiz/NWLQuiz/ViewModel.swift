//
//  ViewModel.swift
//  NWLQuiz
//
//  Created by Nawal Ahmed on 13/09/2023.
//

import Foundation

struct MyRequest: Request {
    
    let url: URL
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

let myUrl = URL(string: Constants.apiURL)!

let myRequest = MyRequest(url: myUrl)
let urlRequest = myRequest.urlRequest

class ViewModel: ObservableObject {
    let serviceHandler: Service?
    
    init(serviceHandler: Service = NetworkService()){
        self.serviceHandler = serviceHandler
        
    }
    
    var questionData: QData?
    @Published var questions: [Question]?
    
    
    func fetchQuestion(_ completion: @escaping() -> ()) {
        
        
        serviceHandler?.get(request: myRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("Fetched new data")
 
                    let jsonDecoder = JSONDecoder()
                    let empData = try! jsonDecoder.decode(QData.self, from: data)
                    self.questionData = empData
                    self.questions = self.questionData?.results
                    print(empData)
                    completion()



                case .failure(let error):
                    print(error)
                }
            }

        }

    }
    


}

