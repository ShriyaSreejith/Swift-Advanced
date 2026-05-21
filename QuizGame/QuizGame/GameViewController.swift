//
//  GameViewController.swift
//  QuizGame
//
//  Created by Sreejith, Shriya (Student) on 1/31/26.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameModels = [Question]()
    var currentQuestion: Question?
    var score = 0
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestions()
        table.delegate = self
        table.dataSource = self
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question){
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    private func setupQuestions(){
        gameModels.append(Question(text: "What is 2 + 2", answers: [
            Answer(text: "2", correct: false),
            Answer(text: "4", correct: true),
            Answer(text: "1", correct: false),
            Answer(text: "8", correct: false),
        ]))
        
        gameModels.append(Question(text: "What is 6 + 7", answers: [
            Answer(text: "15", correct: false),
            Answer(text: "18", correct: false),
            Answer(text: "13", correct: true),
            Answer(text: "17", correct: false),
        ]))
        
        gameModels.append(Question(text: "What is 4 + 2", answers: [
            Answer(text: "6", correct: true),
            Answer(text: "2", correct: false),
            Answer(text: "8", correct: false),
            Answer(text: "3", correct: false),
        ]))
        
        gameModels.append(Question(text: "What is 8 + 9", answers: [
            Answer(text: "17", correct: true),
            Answer(text: "14", correct: false),
            Answer(text: "10", correct: false),
            Answer(text: "18", correct: false),
        ]))
    }
    // table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentQuestion else{
            return
        }
        let answer = question.answers[indexPath.row]
        if checkAnswer(answer: answer, question: question){
            score += 1
            if let index = gameModels.firstIndex(where: { $0.text == question.text}) {
                if index < (gameModels.count - 1){
                    //next question
                    let nextQuestion = gameModels[index+1]
                    print("\(nextQuestion.text)")
                    //currentQuestion = nil
                    configureUI(question: nextQuestion)
                }
                else{
                    //end of game
                    let alert = UIAlertController(title: "Done", message: "You beat the game!\nScore: \(score)/\(gameModels.count)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                }
            }
        }
        else {
            let alert = UIAlertController(
                title: "Wrong",
                message: "That was the wrong answer!",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Next Question", style: .default) { _ in
                if let index = self.gameModels.firstIndex(where: { $0.text == question.text }) {
                    if index < self.gameModels.count - 1 {
                        let nextQuestion = self.gameModels[index + 1]
                        self.configureUI(question: nextQuestion)
                    } else {
                        let endAlert = UIAlertController(
                            title: "Done",
                            message: "Game over!\nScore: \(self.score)/\(self.gameModels.count)",
                            preferredStyle: .alert
                        )
                        endAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                        self.present(endAlert, animated: true)
                    }
                }
            })
            
            present(alert, animated: true)
        }
    }
}


struct Question{
    let text: String
    let answers: [Answer]
}
struct Answer{
    let text: String
    let correct: Bool //true //false
}
