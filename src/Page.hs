module Page (
  Page(..)
) where

data Page =
  Dashboard
  | Document {
    _documentId :: String
  }
  deriving (Show)
