//
//  QuizManager.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 12/12/22.
//

import Foundation

class QuizManager {
    let quizes: [Quiz]
    var score: Int
    var quiz: Quiz?
    
    init(){
        score = 0
        let quizURL = Bundle.main.url(forResource: "quiz", withExtension: "json")!
        do{
            let quizData = try Data(contentsOf: quizURL)
            quizes = try JSONDecoder().decode([Quiz].self, from: quizData)
        } catch {
            print(error)
            quizes = []
        }
    }
    
    func getRandomQuiz() -> Quiz {
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count)))
        let sortedQuiz = quizes[quizIndex]
        quiz = sortedQuiz
        return sortedQuiz
    }
    
    func checkAnswer(_ answer: String) {
        guard let quiz = quiz else {return}
        if answer == quiz.correctAnswer {
            score += 10
            print (score)
        }
        
    }
}

struct Quiz: Codable {
    let answer: String
    let options: [String]
    let correctAnswer:String
}
