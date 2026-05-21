//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Sreejith, Shriya (Student) on 1/25/26.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}
enum State {
    case question
    case answer
    case score
}

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        mode = .flashCard
        // Do any additional setup after loading the view.
    }
    
    
    func updateElement() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        answerLabel.text = "?"
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        updateUI()
    }
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1

        if currentElementIndex >= elementList.count {
            if mode == .quiz {
                state = .score
                updateUI()
                return
            } else {
                currentElementIndex = 0
            }
        }

            state = .question
            updateUI()
    }
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    

    let fixedElementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var elementList: [String] = []
    var currentElementIndex = 0
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard:
                setupFlashCards()
            case .quiz:
                setupQuiz()
            }
            updateUI()
        }
    }
    var state: State = .question
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    func updateFlashCardUI(elementName: String) {
        textField.isHidden = true
        textField.resignFirstResponder()
        if state == .answer {
            answerLabel.text = elementName
        }else{
            answerLabel.text = "?"
        }
        modeSelector.selectedSegmentIndex = 0
        showAnswerButton.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("Next Element", for: .normal)
    }
    
    func updateQuizUI(elementName: String) {
        textField.isHidden = false
        modeSelector.selectedSegmentIndex = 1
        showAnswerButton.isHidden = true
        
        switch state {
        case .question:
            textField.isEnabled = true
            textField.text = ""
            textField.becomeFirstResponder()
            answerLabel.text = ""
            nextButton.isEnabled = false
        case .answer:
            textField.isEnabled = false
            textField.resignFirstResponder()
            answerLabel.text = answerIsCorrect ? "Correct!" : "❌ Correct Answer: \(elementName)"
            nextButton.isEnabled = true
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
            nextButton.isEnabled = false
            displayScoreAlert()
        }

        nextButton.setTitle(currentElementIndex == elementList.count - 1 ? "Show Score" : "Next Question", for: .normal)
        
    }
    func updateUI() {
        let elementName = elementList[currentElementIndex]
        imageView.image = UIImage(named: elementName)
        
        switch mode {
        case .flashCard: updateFlashCardUI(elementName: elementName)
        case .quiz: updateQuizUI(elementName: elementName)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        let correctAnswer = elementList[currentElementIndex]
        answerIsCorrect = (text.lowercased() == correctAnswer.lowercased())
        state = .answer
        updateUI()
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        }else{
            mode = .quiz
        }
    }
    func displayScoreAlert() {
        let alert = UIAlertController(
            title: "Quiz Score",
            message: "Your score is \(correctAnswerCount) out of \(elementList.count).",
            preferredStyle: .alert
        )
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    func setupFlashCards(){
        state = .question
        currentElementIndex = 0
        elementList = fixedElementList
    }
    
    func setupQuiz(){
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
        elementList = fixedElementList.shuffled()
    }
    

}

