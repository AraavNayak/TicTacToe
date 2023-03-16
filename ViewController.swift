//
//  ViewController.swift
//  TicTacToe
//
//  Created by Araav Nayak on 4/23/22.
//




import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Nought;
        case Cross
    }
    
    
    
    
    
    @IBOutlet weak var turnLabel: UILabel!
    
    //@IBOutlet var turnLabel: UILabel!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c1: UIButton!
    
    
   
    
    @IBOutlet weak var crossesScore: UILabel!
    @IBOutlet weak var noughtsScore: UILabel!

    var cScore = 0 //crosses
    var nScore = 0 //noughts
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    //turnLabel = firstTurn;
    
    var NOUGHT = "O"
    var CROSS = "X"
    
    var board = [UIButton]()

    
    var op: Bool?
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBoard();
    }
    
    
    
    func initBoard() {
            board.append(a1)
            board.append(a2)
            board.append(a3)
            board.append(b1)
            board.append(b2)
            board.append(b3)
            board.append(c1)
            board.append(c2)
            board.append(c3)
        
    }
    
    
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        
        addToBoard(sender)

        if checkForVictory(CROSS) {
            cScore += 1
            crossesScore.text = String(cScore)
            resultAlert(title: "Crosses Win!")
        }
        
        if checkForVictory(NOUGHT) {
            nScore += 1
            noughtsScore.text = String(nScore)
            resultAlert(title: "Noughts Win!")
        }
        
        if(fullBoard()) {
            resultAlert(title: "Draw")
        }
    }
    

    func checkForVictory(_ s :String) -> Bool
    {
        
        //Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        
        //Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        
        //Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {

        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    
    
    func resetBoard() {
        for button in board {
            button.setTitle("", for: .normal)
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            //turnLabel.text = CROSS
        }
        
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            //turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                return false;
            }
        }
        
        
        return true;
    }
    
    
    func computerPlayMove() {
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                
                //if Int.random(in: 1..<100) % 2 == 0 {
                button.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = "O"
                break
                //}
            }
        }
    }
    
    


    func aiMove() {

        var bestScore = -2;
        var bestMove:UIButton = a1;
        
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                button.setTitle("X", for: .normal)
                let score = minimax(button:button, turn:0); //0 means true; computer turn
                button.setTitle("", for: .normal)
                if(score >= bestScore) {
                    bestScore = score;
                    bestMove = button;
                }
            }
        }
    
        if bestScore != -2 {
            if bestMove == a1 {
                a1.setTitle("X", for: .normal)
            } else if bestMove == a2 {
                a2.setTitle("X", for: .normal)
            } else if bestMove == a3 {
                a3.setTitle("X", for: .normal)
            } else if bestMove == b1 {
                b1.setTitle("X", for: .normal)
            } else if bestMove == b2 {
                b3.setTitle("X", for: .normal)
            } else if bestMove == c1 {
                c1.setTitle("X", for: .normal)
            } else if bestMove == c2 {
                c2.setTitle("X", for: .normal)
            } else if bestMove == c3 {
                c3.setTitle("X", for: .normal)
            } else {
                //resultAlert(title: "Error 404: No moves left")
                
                
                
                for button in board {
                    if(button.title(for: .normal)?.isEmpty ?? true) {
                        button.setTitle("X", for: .normal)
                        break;
                    }
                }
                
                
                
            }
        } else {
            resultAlert(title: "No moves left")
        }
    
    }

    
    //should show win percentage by using alpha beta
    //evaluates all possible outcomes (alpha beta pruning)
    //determines probability of winning/losing
    //future game idea
    
    func isDraw() -> Bool {
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                return false
            }
        }
        return true
    }
    
    func minimax(button:UIButton, turn:Int) -> Int {
        
        if checkForVictory(CROSS) == true {
            return 1;
        } else if checkForVictory(NOUGHT) == true {
            return -1;
        } else if isDraw() == true {
            return 0;
        }
        
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                button.setTitle(turn % 2 == 0 ? "O" : "X", for: .normal) //dependent on whose turn it is
                let score = minimax(button: button, turn: turn+1);
                button.setTitle("", for: .normal)
                return score;
                //button.setTitle("", for: .normal)
            }
        }
        
        //couple things to keep track of here:
        //whose turn is it?
        //depth??
        
        
        //return 1
        return 0
    }

    
    
    @IBAction func addToBoard(_ sender: UIButton) {
        sender.setTitle(NOUGHT, for: .normal)
        currentTurn = Turn.Cross
        turnLabel.text = "X"
        
        
        if !checkForVictory(NOUGHT) && !isDraw() {
            //computerPlayMove()
            aiMove()
        }
        currentTurn = Turn.Nought
        turnLabel.text = "O"
    
        
    }
}

