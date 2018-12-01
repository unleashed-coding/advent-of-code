import Data.List (scanl')
import Data.Map (Map)
import qualified Data.Map as M
import System.Environment (getArgs)

readInt :: String -> Int
readInt = read

parse :: String -> Int -> Int
parse ('+':n) = (+ readInt n)
parse ('-':n) = subtract (readInt n)

loop :: Int -> [String] -> [Int]
loop acc lst =
  scanl' (flip ($)) acc $ cycle (map parse lst)

appearTwice :: Ord a => [a] -> Maybe a
appearTwice = rec M.empty where
  rec seen [] = Nothing
  rec seen (x:xs) =
    case M.lookup x seen of
      Nothing -> rec (M.insert x x seen) xs
      Just found -> Just found

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> putStrLn "Usage: ./appositum input.txt"
    (arg:_) -> readFile arg >>= print . appearTwice . loop 0 . lines
