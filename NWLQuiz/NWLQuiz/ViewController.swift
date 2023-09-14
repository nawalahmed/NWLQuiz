//
//  ViewController.swift
//  NWLQuiz
//
//  Created by Nawal Ahmed on 13/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var questionBackground: UIView!
    @IBOutlet weak var question: UILabel!
    
    let viewModel = ViewModel()
    
    var questions: [Question]?
    
    var quest: Question?
    
    @IBOutlet weak var choice1: UILabel!
    @IBOutlet weak var choice2: UILabel!
    @IBOutlet weak var choice3: UILabel!
    @IBOutlet weak var choice4: UILabel!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    @IBOutlet weak var btnOption4: UIButton!
    
    var randomInt: Int = 0
    
    var correctAnswer: String?
    var selectedOption = ""
    
    var isCorrect = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        submit.layer.cornerRadius = 5
        questionBackground.layer.cornerRadius = 10
        questionBackground.layer.masksToBounds = true
        refreshScreen()
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        var message = ""
        var title = ""
        
        if(self.isCorrect) {
            
            title = "Great job"
            message = "The answer is correct"
        } else {
            
            title = "Oops"
            message = "Try again?"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true) {
            self.refreshScreen()
        }
        self.isCorrect = false
    }
    
    fileprivate func resetButtons() {
        
        btnOption1.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
        btnOption2.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
        btnOption3.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
        btnOption4.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
    }
    
    func updateUI() {
        self.randomInt = Int.random(in: 0..<(self.questions?.count ?? 0) - 1)
       
        self.quest = self.questions?[self.randomInt]
        
        self.question.text = self.quest?.question
        
        var choices = self.quest?.incorrect_answers
        choices?.append(self.quest?.correct_answer ?? "")
        choices?.shuffle()
        
        self.choice1.text = choices?[0]
        self.choice2.text = choices?[1]
        self.choice3.text = choices?[2]
        self.choice4.text = choices?[3]
        
        resetButtons()
    }
    
    func refreshScreen() {
        
        if(self.questions != nil) {
            self.updateUI()
        } else {
            self.viewModel.fetchQuestion{
                self.questions = self.viewModel.questionData?.results
                self.updateUI()
            }
        }
        
    }
    
    func updateButtons() {
        
        if(selectedOption == choice1.text) {
            
            btnOption1.setImage(UIImage(systemName: "smallcircle.filled.circle.fill"), for: .normal)
            btnOption2.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption3.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption4.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)

        }
        if(selectedOption == choice2.text) {
            btnOption1.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption2.setImage(UIImage(systemName: "smallcircle.filled.circle.fill"), for: .normal)
            btnOption3.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption4.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)

        }
        if(selectedOption == choice3.text) {
            btnOption1.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption2.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption3.setImage(UIImage(systemName: "smallcircle.filled.circle.fill"), for: .normal)
            btnOption4.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)

        }
        if(selectedOption == choice4.text) {
            btnOption1.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption2.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption3.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
            btnOption4.setImage(UIImage(systemName: "smallcircle.filled.circle.fill"), for: .normal)

        }
        
    }
    
    @IBAction func optionA(_ sender: Any) {
        
        selectedOption = choice1.text ?? ""
        isCorrect = (choice1.text == self.quest?.correct_answer) ? true : false
        updateButtons()
    }
    
    @IBAction func optionB(_ sender: Any) {
        selectedOption = choice2.text ?? ""
        isCorrect = (choice2.text == self.quest?.correct_answer) ? true : false

        updateButtons()

    }
    
    @IBAction func optionC(_ sender: Any) {
        selectedOption = choice3.text ?? ""
        isCorrect = (choice3.text == self.quest?.correct_answer) ? true : false

        updateButtons()

    }
    
    @IBAction func optionD(_ sender: Any) {
        selectedOption = choice4.text ?? ""
        isCorrect = (choice4.text == self.quest?.correct_answer) ? true : false

        updateButtons()

    }
    
}


