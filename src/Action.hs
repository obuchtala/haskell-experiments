module Action (
  Action(..)
) where


data Action =
  Authenticate {
    userId :: String,
    token :: String
  }
  | OpenDashboard
  | OpenDocument {
    documentId :: String
  }
  deriving (Show)
