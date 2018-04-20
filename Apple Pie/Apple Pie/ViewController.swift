//
//  ViewController.swift
//  Apple Pie
//
//  Created by Zooey Bossert on 18-04-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["pizza", "room", "bug", "program", "code", "bottle"]
    let incorrectMovesAllowed = 7
    
    // Make score
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // Connect to the game struct
    var currentGame: Game!
    
    // Connecting the image
    @IBOutlet weak var treeImageView: UIImageView!
    
    // Connecting the label for the correct word
    @IBOutlet weak var correctWordLabel: UILabel!
    
    // Connecting the label for the score
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Connecting all the buttons with an action
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter:letter)
        updateGameState()
    }
    
    // Make a function to update score
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }
        else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // function to enable letter when pressed
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // function to create new round
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            updateUI()
        }
        else {
            enableLetterButtons(false)
        }
        
    }
    
    // function to update the interface
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

