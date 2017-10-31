module Engine.Utils exposing (..)

import Maybe exposing (..)
import Array2D exposing (..)
import Types.Pieces exposing (..)
import Types.Space exposing (..)
import Types.Player exposing (..)

checkSpace : Player -> Space -> Maybe Space
checkSpace player space =
    case space.piece of
        Nothing ->
            Just space

        Just piece ->
            if (getOwner piece).colour == player.colour then
                Nothing
            else
                Just space
                

toggleSpaces : Bool -> List Space -> Grid -> Grid
toggleSpaces flag spaces grid =
    case spaces of
        [] ->
            grid

        f :: rest ->
            let
                (Coordinate x y) =
                    f.location

                gridItem =
                    Array2D.get x y grid

                newGrid =
                    Maybe.map
                        (\item ->
                            Array2D.set x
                                y
                                { item
                                    | active = flag
                                }
                                grid
                        )
                        gridItem
            in
                toggleSpaces flag rest (withDefault grid newGrid)

resetGrid = toggleSpaces False

movesToGrid = toggleSpaces True