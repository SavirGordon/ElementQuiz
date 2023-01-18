//
//  ViewController.swift
//  ElementQuiz
//
//  Created by 4d on 1/18/23.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    var mode: Mode = .flashCard
    var state: State = .question
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0

    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
    // Get the text from the text field
        let textFieldContents = textField.text!
    // Determine whether the user answered correctly and update appropriate quiz// state
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        }
        else {
            answerIsCorrect = false
        }
        // The app should now display the answer to the user
        state = .answer
        updateUI()
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    // Updates the app's UI in flash card mode.
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        if state == .answer {
            answerLabel.text = elementName
        }
        else {
            answerLabel.text = "?"
        }
    }
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI() {
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                print("Correct!")
            }
            else {
                print("❌")
            }
        }
    }
    
    func updateUI() {
        switch mode
        {
            case.flashCard: updateFlashCardUI()
            case.quiz: updateQuizUI()
        }
    }
    
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var modeSelector: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    @IBOutlet var answerLabel: UILabel!
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        updateUI()
    }
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex == elementList.count {
            currentElementIndex = 0
        }
        state = .question
        updateUI()
    }
}
