//
//  Questions.swift
//  NWLQuiz
//
//  Created by Nawal Ahmed on 13/09/2023.
//

import Foundation

struct QData: Codable {
    var results: [Question]?
}

struct Question: Codable {
    
    let question: String?
    let incorrect_answers: [String]?
    let correct_answer: String?
}
