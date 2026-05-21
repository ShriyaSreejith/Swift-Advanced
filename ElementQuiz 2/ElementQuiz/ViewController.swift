//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Lilly Ye on 1/24/26.
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
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    let fixedElementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var elementList: [String] = []
    
    var currentElementIndex = 0
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard: setupFlashCards()
            case .quiz: setupQuiz()
            }
            updateUI()
        }
    }
    
    var state: State = .question
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        mode = .flashCard
    }
    
    // MARK: - Actions
    
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
    
    @IBAction func switchModes(_ sender: Any) {
        mode = modeSelector.selectedSegmentIndex == 0 ? .flashCard : .quiz
    }
    
    // MARK: - UI Updates
    
    func updateFlashCardUI(elementName: String) {
        textField.isHidden = true
        textField.resignFirstResponder()
        
        answerLabel.text = (state == .answer) ? elementName : "?"
        showAnswerButton.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("Next Element", for: .normal)
        
        modeSelector.selectedSegmentIndex = 0
    }
    
    func updateQuizUI(elementName: String) {
        textField.isHidden = false
        
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
            answerLabel.text = answerIsCorrect ? "Correct!" : "❌ Correct: \(elementName)"
            nextButton.isEnabled = true
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
            showAnswerButton.isHidden = true
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
    
    // MARK: - Text Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        let correctAnswer = elementList[currentElementIndex]
        
        answerIsCorrect = (text.lowercased() == correctAnswer.lowercased())
        state = .answer
        updateUI()
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Score
    
    func displayScoreAlert() {
        let alert = UIAlertController(
            title: "Quiz Score",
            message: "Your score is \(correctAnswerCount) out of \(elementList.count).",
            preferredStyle: .alert
        )
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    // MARK: - Setup
    
    func setupFlashCards() {
        state = .question
        currentElementIndex = 0
        elementList = fixedElementList
    }
    
    func setupQuiz() {
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
        elementList = fixedElementList.shuffled()
    }
}
