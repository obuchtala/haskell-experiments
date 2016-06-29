module Main where

import App
import qualified Role as R
import qualified Page as P
import qualified Action as A

login :: String -> String -> Maybe State
login userId token = do
  return (State P.Dashboard R.Guest)
    >>= performAction (A.Authenticate userId token)

open :: String -> State -> Maybe State
open documentId state =
  (performAction (A.OpenDocument documentId) state)

main :: IO ()
main = do
  print ( (login "user1" "123") >>= open "mine" )

