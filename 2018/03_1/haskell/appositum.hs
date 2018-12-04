{-# LANGUAGE RecordWildCards #-}

import Control.Applicative (some)
import Data.Map (Map)
import qualified Data.Map as M
import Text.Parsec (char, digit, parse, spaces, Parsec)
import System.Environment (getArgs)

data Claim = MkClaim
  { claimId, leftEdge, topEdge, width, height :: !Integer
  } deriving (Eq, Show)

type Fabric = Map (Integer, Integer) Integer
type Parser = Parsec String ()

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> putStrLn "Usage: ./appositum input.txt"
    (arg:_) -> do
      readFile arg >>= print . overlap . cut . getClaims . lines

cut :: [Claim] -> Fabric
cut = occurrences . concatMap coords

overlap :: Fabric -> Integer
overlap = count (>1)

count :: Foldable t => (a -> Bool) -> t a -> Integer
count p = foldr (\x acc -> if p x then acc+1 else acc) 0

occurrences :: Ord a => [a] -> Map a Integer
occurrences = M.fromListWith (+) . map (\x -> (x,1))

coords :: Claim -> [(Integer, Integer)]
coords MkClaim{..} = do
  x <- [leftEdge .. leftEdge + width  - 1]
  y <- [topEdge  .. topEdge  + height - 1]
  pure (x,y)

getClaims :: [String] -> [Claim]
getClaims = map (justs . parse parseClaim mempty) where
  justs (Right x) = x

parseClaim :: Parser Claim
parseClaim = do
  char '#'
  claimID <- integer
  symbolic '@'
  left <- integer
  symbolic ','
  top <- integer
  symbolic ':'
  width <- integer
  char 'x'
  height <- integer
  pure $ MkClaim claimID left top width height

integer :: Parser Integer
integer = read <$> some digit

symbolic :: Char -> Parser Char
symbolic c = spaces *> char c <* spaces
