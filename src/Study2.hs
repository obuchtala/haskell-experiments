module Study2 (
  unlockDoors,
  unlockDoor,
) where

{-
  Example 1
  A non-deterministic monadic implementation of a flow of actions.
  Using the Maybe monad you can write a chain of operations.
  If at some point the result is turned into Nothing the monad will not propagate
  further down the chain.

  tl;tr:
    By just using a monad in the return value you can chain functions
    in a do block. Could be interesting to be able to implement
    'workflows' like in an imperative language not needing to deal with vagueness
    due to errors, or say lack of permissions.
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


-- Provide a list of ints as a guess for the secret.
-- Then you might get a result -- maybe.
unlockDoors :: [Int] -> Either String Bool
unlockDoors keys = do
  doors <- Right keys
    >>= unlockDoor 1
    >>= unlockDoor 2
    >>= unlockDoor 3
  return (isUnlocked doors)
