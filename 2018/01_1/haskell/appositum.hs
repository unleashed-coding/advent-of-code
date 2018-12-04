import Data.Foldable (foldl')
import System.Environment (getArgs)

readInt :: String -> Int
readInt = read

parse :: String -> Int -> Int
parse ('+':n) = (+ readInt n)
parse ('-':n) = subtract (readInt n)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> putStrLn "Usage: ./appositum input.txt"
    (arg:_) -> readFile arg
           >>= print . foldl' (flip ($)) 0 . map parse . lines
