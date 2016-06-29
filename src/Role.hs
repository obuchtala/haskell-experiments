module Role (
  Role(..)
) where

data Role =
  User {
    _userId :: String
  }
  | Administrator {
    _userId :: String
  }
  | Guest
  deriving (Show)
