//
//  NWLQuizTests.swift
//  NWLQuizTests
//
//  Created by Nawal Ahmed on 13/09/2023.
//

import XCTest
@testable import NWLQuiz
final class NWLQuizTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    class QuizTests: XCTestCase {
        
        var vc: ViewController!
        
        override func setUp() {
            // Put setup code here. This method is called before the invocation of each test method in the class.
            super.setUp()
            vc = ViewController()
        }
        
        func testGetCurrentQuestion() {
            
            let questions = [
                
                Question(question: "What is 2 + 2?", incorrect_answers: ["3", "5", "6"], correct_answer: "4"),
                Question(question: "What is the capital of France?", incorrect_answers: ["London", "Berlin", "Amsterdam"], correct_answer: "Paris"),
            ]
            
            
            vc.questions = questions
            
            
            
            // Assert
            XCTAssertNotNil(vc.quest)
            XCTAssertNotNil(vc.choice1)
            XCTAssertNotNil(vc.choice2)
            XCTAssertNotNil(vc.choice3)
            XCTAssertNotNil(vc.choice4)
        }
        
        func testOptionSelection() {
        
            let expectedImage = UIImage(named: "smallcircle.filled.circle.fill")
            
            let currentImage = vc.btnOption1.image(for: .normal)
            
            vc.btnOption1.sendActions(for: .touchUpInside)
            
            XCTAssertNotEqual(currentImage!, expectedImage, "Button image did not change on touch event")
            
        }
        
        func testSubmit() {
        
            vc.btnOption1.sendActions(for: .touchUpInside)
            vc.submit(self)
                    
                    
            let alert = vc.presentedViewController as? UIAlertController
            XCTAssertNotNil(alert, "Alert controller was not presented")
                    
        }
        
        func testForResults() {
            
            let questions = [
                
                Question(question: "What is 2 + 2?", incorrect_answers: ["3", "5", "6"], correct_answer: "4")
            ]
            
            
            vc.questions = questions
            
            vc.btnOption2.sendActions(for: .touchUpInside)
            vc.submit(self)
                    
                    
            let alert = vc.presentedViewController as? UIAlertController
            XCTAssertNotNil(alert, "Alert controller was not presented")
            
            
            XCTAssertEqual(alert?.title, "Great job", "Unexpected alert title")
            XCTAssertEqual(alert?.message, "The answer is correct", "Unexpected alert message")
            
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            vc = nil
            super.tearDown()
        }
        

    }

}
