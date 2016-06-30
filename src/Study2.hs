module Study2 (
  unlockDoors
) where

{-
  Same as Study1 but using Either instead of Maybe
-}
unlockDoor :: Int -> [Int] ->  Either String [Int]
unlockDoor _ [] = Right []
unlockDoor key (secret:xs) =
  if (key /= secret) then Left "nope"
  else (Right xs)

isUnlocked :: [Int] -> Bool
isUnlocked xs
  | length xs == 0    = True
  | otherwise         = False

unlockDoors :: [Int] -> Either String Bool
unlockDoors keys = do
  doors <- Right keys
    >>= unlockDoor 1
    >>= unlockDoor 2
    >>= unlockDoor 3
  return (isUnlocked doors)
