import Data.String

subtract : Neg a => a -> a -> a
subtract x y = y - x

parse : List Char -> Integer -> Integer
parse (x::xs) =
  case parseInteger (pack xs) of
    Nothing => id
    Just num =>
      case x of
        '+' => (+num)
        '-' => subtract num

loop : Integer -> List (List Char) -> Integer
loop acc lst = foldl (\x, f => f x) acc (map parse lst)

main : IO ()
main = do
  args <- getArgs
  case args of
    (_::arg::_) => do
      file <- readFile arg
      case file of
        Right res => print $ loop 0 $ map unpack (lines res)
        Left _ => putStrLn "File not found"
    _ => putStrLn "Usage: ./appositum input.txt"
