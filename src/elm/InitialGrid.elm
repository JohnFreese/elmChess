module InitialGrid exposing (..)

import Array2D exposing (..)
import Types.Pieces exposing (..)
import Types.Player exposing (..)
import Types.Space exposing (..)


initialGrid : Grid
initialGrid =
    fromList
        [ [ (Space White (Just (Rook (Player Black 0 True))) (Coordinate 0 0) False)
          , (Space Black (Just (Knight (Player Black 0 True))) (Coordinate 0 1) False)
          , (Space White (Just (Bishop (Player Black 0 True))) (Coordinate 0 2) False)
          , (Space Black (Just (Queen (Player Black 0 True))) (Coordinate 0 3) False)
          , (Space White (Just (King (Player Black 0 True))) (Coordinate 0 4) False)
          , (Space Black (Just (Bishop (Player Black 0 True))) (Coordinate 0 5) False)
          , (Space White (Just (Knight (Player Black 0 True))) (Coordinate 0 6) False)
          , (Space Black (Just (Rook (Player Black 0 True))) (Coordinate 0 7) False)
          ]
        , [ (Space Black (Just (Pawn (Player Black 0 True))) (Coordinate 1 0) False)
          , (Space White (Just (Pawn (Player Black 0 True))) (Coordinate 1 1) False)
          , (Space Black (Just (Pawn (Player Black 0 True))) (Coordinate 1 2) False)
          , (Space White (Just (Pawn (Player Black 0 True))) (Coordinate 1 3) False)
          , (Space Black (Just (Pawn (Player Black 0 True))) (Coordinate 1 4) False)
          , (Space White (Just (Pawn (Player Black 0 True))) (Coordinate 1 5) False)
          , (Space Black (Just (Pawn (Player Black 0 True))) (Coordinate 1 6) False)
          , (Space White (Just (Pawn (Player Black 0 True))) (Coordinate 1 7) False)
          ]
        , [ (Space White Nothing (Coordinate 2 0) False)
          , (Space Black Nothing (Coordinate 2 1) False)
          , (Space White Nothing (Coordinate 2 2) False)
          , (Space Black Nothing (Coordinate 2 3) False)
          , (Space White Nothing (Coordinate 2 4) False)
          , (Space Black Nothing (Coordinate 2 5) False)
          , (Space White Nothing (Coordinate 2 6) False)
          , (Space Black Nothing (Coordinate 2 7) False)
          ]
        , [ (Space Black Nothing (Coordinate 3 0) False)
          , (Space White Nothing (Coordinate 3 1) False)
          , (Space Black Nothing (Coordinate 3 2) False)
          , (Space White Nothing (Coordinate 3 3) False)
          , (Space Black Nothing (Coordinate 3 4) False)
          , (Space White Nothing (Coordinate 3 5) False)
          , (Space Black Nothing (Coordinate 3 6) False)
          , (Space White Nothing (Coordinate 3 7) False)
          ]
        , [ (Space White Nothing (Coordinate 4 0) False)
          , (Space Black Nothing (Coordinate 4 1) False)
          , (Space White Nothing (Coordinate 4 2) False)
          , (Space Black Nothing (Coordinate 4 3) False)
          , (Space White Nothing (Coordinate 4 4) False)
          , (Space Black Nothing (Coordinate 4 5) False)
          , (Space White Nothing (Coordinate 4 6) False)
          , (Space Black Nothing (Coordinate 4 7) False)
          ]
        , [ (Space Black Nothing (Coordinate 5 0) False)
          , (Space White Nothing (Coordinate 5 1) False)
          , (Space Black Nothing (Coordinate 5 2) False)
          , (Space White Nothing (Coordinate 5 3) False)
          , (Space Black Nothing (Coordinate 5 4) False)
          , (Space White Nothing (Coordinate 5 5) False)
          , (Space Black Nothing (Coordinate 5 6) False)
          , (Space White Nothing (Coordinate 5 7) False)
          ]
        , [ (Space White (Just (Pawn (Player White 0 True))) (Coordinate 6 0) False)
          , (Space Black (Just (Pawn (Player White 0 True))) (Coordinate 6 1) False)
          , (Space White (Just (Pawn (Player White 0 True))) (Coordinate 6 2) False)
          , (Space Black (Just (Pawn (Player White 0 True))) (Coordinate 6 3) False)
          , (Space White (Just (Pawn (Player White 0 True))) (Coordinate 6 4) False)
          , (Space Black (Just (Pawn (Player White 0 True))) (Coordinate 6 5) False)
          , (Space White (Just (Pawn (Player White 0 True))) (Coordinate 6 6) False)
          , (Space Black (Just (Pawn (Player White 0 True))) (Coordinate 6 7)False)
          ]
        , [ (Space Black (Just (Rook (Player White 0 True))) (Coordinate 7 0) False)
          , (Space White (Just (Knight (Player White 0 True))) (Coordinate 7 1) False)
          , (Space Black (Just (Bishop (Player White 0 True))) (Coordinate 7 2) False)
          , (Space White (Just (Queen (Player White 0 True))) (Coordinate 7 3) False)
          , (Space Black (Just (King (Player White 0 True))) (Coordinate 7 4) False)
          , (Space White (Just (Bishop (Player White 0 True))) (Coordinate 7 5) False)
          , (Space Black (Just (Knight (Player White 0 True))) (Coordinate 7 6) False)
          , (Space White (Just (Rook (Player White 0 True))) (Coordinate 7 7) False)
          ]
        ]
