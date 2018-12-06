{-# LANGUAGE RecordWildCards #-}

import           Control.Applicative (some)
import           Control.Monad       (guard)
import           Data.Map            (Map)
import qualified Data.Map            as M
import           System.Environment  (getArgs)
import           Text.Parsec         (Parsec, char, digit, parse, spaces)

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
      f <- readFile arg
      let claims = getClaims $ lines f
      let fabric = cut claims
      print $ noOverlap fabric claims

cut :: [Claim] -> Fabric
cut = occurrences . concatMap coords

overlap :: Fabric -> Integer
overlap = count (>1)

noOverlap :: Fabric -> [Claim] -> Integer
noOverlap fabric getClaims = head $ do
  claim <- getClaims
  let intersec = M.intersection fabric (cut [claim])
  guard $ all (== 1) intersec
  pure $ claimId claim

count :: Foldable t => (a -> Bool) -> t a -> Integer
count p = foldr f 0 where
  f x z = if p x then z + 1 else z

occurrences :: Ord a => [a] -> Map a Integer
occurrences = M.fromListWith (+) . map (\x -> (x, 1))

coords :: Claim -> [(Integer, Integer)]
coords MkClaim {..} = do
  x <- [leftEdge .. leftEdge + width - 1]
  y <- [topEdge .. topEdge + height - 1]
  pure (x, y)

getClaims :: [String] -> [Claim]
getClaims = map (justs . parse parseClaim mempty)
  where justs (Right x) = x

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
