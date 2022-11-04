//
//  ChessGame.swift
//  Chess
//
//  Created by Eliel Kilembo on 10/24/22.
//  Copyright © 2022 Eliel Vipata. All rights reserved.
//

import Foundation
struct ChessMove: Equatable {
    var from, to: Position
}

enum ChessGameState {
    case idle
    case check
    case checkMate
    case staleMate
    case location_defended
    case opposing_pieces
}

struct ChessGame {
    private(set) var board: Board
    private(set) var history: [Move]
}


