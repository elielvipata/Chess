//
//  MinimaxViewController.swift
//  Chess
//
//  Created by Eliel Kilembo on 10/23/22.
//  Copyright © 2022 Nick Lockwood. All rights reserved.
//

import UIKit

class MinimaxViewController: UIViewController {
    private var game = Game()


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var blackOutlet: UISegmentedControl!
    @IBOutlet weak var whiteOutlet: UISegmentedControl!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBAction private func togglePlayerType() {
        makeComputerMove()
    }

    @IBAction private func resetGame() {
        game = Game()
        UIView.animate(withDuration: 0.4, animations: {
            self.boardView?.board = self.game.board
        }, completion: { [weak self] _ in
            self?.update()
        })
        setSelection(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView?.delegate = self
        update()
        // Do any additional setup after loading the view.
    }
}

extension MinimaxViewController: BoardViewDelegate {
    func boardView(_ boardView: BoardView, didTap position: Position) {
        guard let selection = boardView.selection else {
            if game.canSelectPiece(at: position) {
                setSelection(position)
            } else {
                boardView.jigglePiece(at: position)
            }
            return
        }
        guard game.canMove(from: selection, to: position) else {
            if selection == position {
                setSelection(nil)
            } else if game.canSelectPiece(at: position) {
                setSelection(position)
            }
            return
        }
        makeMove(Move(from: selection, to: position))
    }

    private func playerIsHuman(_ color: Color) -> Bool {
        switch color {
        case .white:
            return whiteOutlet?.selectedSegmentIndex == 0
        case.black:
            return blackOutlet?.selectedSegmentIndex == 0
        }
    }

    private func update() {
        let gameState = game.state
        switch gameState {
        case .checkMate, .staleMate:
            let alert = UIAlertController(
                title: "Game Over",
                message: gameState == .staleMate ?
                    "Stalemate: Nobody wins" :
                    "Checkmate: \(game.turn.other) wins",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        case .check:
            boardView?.pulsePiece(at: game.kingPosition(for: game.turn)) {
                self.makeComputerMove()
            }
        case .idle:
            makeComputerMove()
        }
    }
    
    private func evaluateState(state:GameState)->Int{
        return 0;
    }

    private func setSelection(_ position: Position?) {
        let moves = position.map(game.movesForPiece(at:)) ?? []
        UIView.animate(withDuration: 0.2, animations: {
            self.boardView?.selection = position
            self.boardView?.moves = moves
        })
    }
    
    private func max(a:Int, b:Int)->Int{
        if(a >= b){
            return a;
        }else{
            return b;
        }
    }
    
    private func min(a:Int,b:Int)->Int{
        if(a < b){
            return a
        }else{
            return b
        }
    }
    
    
    private func minimax()->Int{
        
        return 0;
    }
    
    private func max_value(state:GameState, depth:Int)->Int{
        switch state{
        case .checkMate:
            return self.evaluateState(state:state)
        case .check:
            return self.evaluateState(state: state)
        case .idle:
            return self.evaluateState(state: state)
        case .staleMate:
            return self.evaluateState(state: state)
        }
        
        var score = -(Int.max);
        let moves = getMoves(agent:0);
        for move in moves{
            print("hello\(score-1), \(move)")
            // Create a successor function for current state
        }
        
        
        return 0;
    }
    

    

    
    private func min_value(state:GameState, depth:Int, agent:Int)->Int{
        let moves = getMoves(agent: agent);
        switch state{
        case .checkMate:
            return self.evaluateState(state: state)
        case .check:
            return self.evaluateState(state: state)
        case .idle:
            return self.evaluateState(state: state)
        case .staleMate:
            return self.evaluateState(state: state)
        }
        
        
        let score = Int.max;
        for _ in moves{
           print(score+1)
        }
        
        return 0;
    }
    
    private func getMoves(agent:Int)->[Move]{
        // agents: 0 = AI, 1 = Player
        var moves:[Move]?
        if(agent == 0){
            if !playerIsHuman(game.turn), let move = game.nextMove(for: game.turn) {
                moves?.append(move)
            }
        }else{
            if playerIsHuman(game.turn), let move = game.nextMove(for: game.turn) {
                moves?.append(move)
            }
        }
        return moves!
    }

    private func makeComputerMove() {
        if !playerIsHuman(game.turn),
           let move = game.nextMove(for: game.turn)
        {
            makeMove(move)
        }
    }
    
    

    private func makeMove(_ move: Move) {
        let position = move.to
        guard let boardView = boardView else {
            return
        }
        let oldGame = game
        game.move(from: move.from, to: position)
        let board1 = game.board
        let kingPosition = game.kingPosition(for: oldGame.turn)
        let wasInCheck = game.pieceIsThreatened(at: kingPosition)
        let wasPromoted = !wasInCheck && game.canPromotePiece(at: position)
        let wasHuman = playerIsHuman(oldGame.turn)
        if wasInCheck {
            game = oldGame
        }
        let board2 = game.board
        UIView.animate(withDuration: 0.4, animations: {
            boardView.selection = nil
            boardView.board = board1
            boardView.moves = []
        }, completion: { [weak self] _ in
            guard let self = self, board2 == self.game.board else { return }
            if wasInCheck {
                UIView.animate(withDuration: 0.2, animations: {
                    boardView.board = board2
                })
                boardView.jigglePiece(at: kingPosition)
                return
            }
            if wasPromoted {
                if !wasHuman {
                    self.game.promotePiece(at: position, to: .queen)
                    let board2 = self.game.board
                    UIView.animate(withDuration: 0.4, animations: {
                        boardView.board = board2
                    }, completion: { [weak self] _ in
                        guard board2 == self?.game.board else { return }
                        self?.update()
                    })
                    return
                }
                let alert = UIAlertController(
                    title: "Promote Pawn",
                    message: nil,
                    preferredStyle: .alert
                )
                for piece in [PieceType.queen, .rook, .bishop, .knight] {
                    alert.addAction(UIAlertAction(
                        title: piece.rawValue.capitalized,
                        style: .default
                    ) { [weak self] _ in
                        guard let self = self else { return }
                        self.game.promotePiece(at: position, to: piece)
                        boardView.board = self.game.board
                        self.update()
                    })
                }
                self.present(alert, animated: true)
            }
            self.update()
        })
    }
}

