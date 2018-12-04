import           Data.Map           (Map)
import qualified Data.Map           as M
import           System.Environment

type Dict = Map Int Char

main :: IO ()
main = do
  args <- getArgs
  case args of
    []      -> putStrLn "Usage: ./appositum input.txt"
    (arg:_) -> readFile arg >>= print . checksum . lines

count :: Eq a => a -> [a] -> Int
count el = length . filter (==el)

zipped :: String -> Dict
zipped xs = M.fromList $ map (\x -> (count x xs, x)) xs

twos :: Dict -> Dict
twos = M.filterWithKey (\k _ -> k == 2)

threes :: Dict -> Dict
threes = M.filterWithKey (\k _ -> k == 3)

checksum :: [String] -> Int
checksum strings = length threes' * length twos' where
  get f = filter (/= M.empty) $ map (f . zipped) strings
  threes' = get threes
  twos' = get twos
