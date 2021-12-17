{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T

import qualified AOC


mainA :: IO ()
mainA = do
  ls <- AOC.readFileTextLines "Day02Input"
  let cord = foldl updatePositionA (0, 0) ls
  print $ uncurry (*) cord

updatePositionA :: (Int, Int) -> T.Text -> (Int, Int)
updatePositionA cord str = do
  let cmd = AOC.parseString parseCommand (T.unpack str)
  (fst cord + fst cmd, snd cord + snd cmd)


mainB :: IO ()
mainB = do
  ls <- AOC.readFileTextLines "Day02Input"
  let (horz, depth, _) = foldl updatePositionB (0, 0, 0) ls
  print $ horz * depth

updatePositionB :: (Int, Int, Int) -> T.Text -> (Int, Int, Int)
updatePositionB (horz, depth, aim) str =
  case AOC.parseString parseCommand (T.unpack str) of
    (0, val) -> (horz , depth, aim + val)
    (val, 0) -> (horz + val, depth + (aim * val), aim)

parseCommand :: AOC.Parser (Int, Int)
parseCommand = do
  command <- AOC.manyTill AOC.anyChar AOC.space
  val <- fmap (read . (:[])) AOC.digit
  case command of
    "forward" -> pure (val, 0)
    "up" -> pure (0, -val)
    "down" -> pure (0, val)
    _ -> fail "oof"

