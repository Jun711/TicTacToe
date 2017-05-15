//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jun Goh on 2017-05-14.
//  Copyright © 2017 Jun Goh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var winner: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    var gameIsActive = true // A Boolean value to keep track when the game ends.
    var hasAWinner = false
    
    // Players by their number reference
    // 0 is unplayed button
    // 1 is Cross
    // 2 is Noughts
    
    var activePlayer = 1 // We start with Cross || Challenge: Try starting with the winner i.e. store the value of the winner
    var gameState = [0 ,0 ,0 ,
                     0 ,0 ,0 ,
                     0 ,0 ,0 ] // From left to right and top to bottom these numbers represent the status of each button
    
    /*
     Tag representation of our button matrix
     
     | 0 | 1 | 2 |
     | 3 | 4 | 5 |
     | 6 | 7 | 8 |
     
     Possible combinations are:
     */
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
        [0, 4, 8], [2, 4, 6]] // Diagonals
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if gameState[sender.tag] == 0 {
            gameState[sender.tag] = activePlayer // We change the state of that position to the players number
            
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "x"), for: UIControlState.normal)
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "o"), for: UIControlState.normal)
                activePlayer = 1
            }
        }
        
        checkGameState()
        
        checkIfDraw()
    }
    
    func checkIfDraw() {
        // Its possible that all states have changed to 1 or 2 and no winner has been found so we also need to check if any 0s are left. In that case its a draw.
        
        gameIsActive = false // Automaticaly assume game has ended as a draw unless there are more states to be played.
        
        for state in gameState {
            if state == 0 {
                gameIsActive = true
                break
            }
        }
        
        if !gameIsActive && !hasAWinner {
            winner.text = "It's a draw"
            winner.isHidden = false
            playAgain.isHidden = false
        }
        
        // Challenge: In case there is a winner by the last state we get a draw. How can we make sure we get the winner?
    }
    
    func checkGameState() {
        // It's possible at this point someone has won the game, so we need to check if the states of our buttons match any of the winning combinations. We need to use a for loop to search through each winning combination and if we found a match, game is over
        
        for combination in winningCombinations {
            // This will go through all the possible combinations in the winningCombinations array. Combination could be [2, 5, 8] as an example here
            
            if (gameState[combination[0]] != 0) && (gameState[combination[0]] == gameState[combination[1]]) && (gameState[combination[1]] == gameState[combination[2]]) {
                // Here we want to make sure the state number is not 0 and all 3 positions are the same state. For example, 1 for the cross.
                
                gameIsActive = false // Game ends because a winning condition is found
                
                // Check to see who won
                if gameState[combination[0]] == 1 {
                    winner.text = "Cross has won"
                } else {
                    winner.text = "Nought has won"
                }
                hasAWinner = true
                winner.isHidden = false
                playAgain.isHidden = false
            }
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        winner.isHidden = true
        winner.sizeToFit()
        winner.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        playAgain.isHidden = true
        
        gameState = [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
        gameIsActive = true
        activePlayer = 1
        
        resetImages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winner.isHidden = true
        winner.backgroundColor = .red
        playAgain.isHidden = true
        resetImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetImages() {
        for button in view.subviews {
            if let button = button as? UIButton {
                button.setImage(nil, for: .normal)
            }
        }
    }

    

}

