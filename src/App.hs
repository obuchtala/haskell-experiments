module App (
  performAction,
  State(..)
) where

import Data.Maybe
import Role(Role)
import qualified Role as R
import Page(Page)
import qualified Page as P
import Action(Action)
import qualified Action as A

data State = State Page Role
  deriving (Show)

performAction :: Action -> State -> Maybe State

-- Authenticate
performAction (A.Authenticate userId token) (State page _)
  | isJust(role)  = Just (State page (fromJust role))
  | otherwise     = Just (State page R.Guest)
  where
    role = (_authenticate userId token)

-- OpenDashboard
performAction (A.OpenDashboard) s@(State P.Dashboard _) = Just s
performAction (A.OpenDashboard) s@(State _ r) = Just (State P.Dashboard r)

-- OpenDocument
performAction (A.OpenDocument documentId) s@(State _ r)
  | authorized = Just (State (P.Document documentId) r)
  | otherwise = Nothing
  where
    authorized = (_authorize documentId r)


_authenticate :: String -> String -> Maybe Role
_authenticate userId token
  | userId == "user1" && token == "123" = Just (R.User userId)
  | userId == "admin" && token == "admin" = Just (R.Administrator userId)
  | otherwise = Nothing

_authorize :: String -> Role -> Bool
_authorize documentId (R.User userId)
  | documentId == "mine" && userId == "user1" = True
  | documentId == "open" = True
  | otherwise = False
_authorize documentId _
  | documentId == "open" = True
  | otherwise = False
