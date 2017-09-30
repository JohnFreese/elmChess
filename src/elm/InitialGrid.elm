module InitialGrid exposing (..)

import Types.Pieces exposing (..)
import Types.Player exposing (..)
import Types.Space exposing (..)


initialGrid : Grid
initialGrid =
    [ [ (Space White (Just (Pawn (Player White 0 True))) (Coordinate 0 0))
      , (Space Black (Just (Knight (Player White 0 True))) (Coordinate 0 0))
      , (Space White (Just(Pawn (Player White 0 True))) (Coordinate 0 0))
      ]
    , [ (Space Black Nothing (Coordinate 0 0))
      , (Space White (Just (Queen (Player White 0 True))) (Coordinate 0 0))
      , (Space Black Nothing (Coordinate 0 0))
      ]
    , [ (Space White Nothing (Coordinate 0 0))
      , (Space Black (Just (King (Player White 0 True))) (Coordinate 0 0))
      , (Space White Nothing (Coordinate 0 0))
      ]
    ]
