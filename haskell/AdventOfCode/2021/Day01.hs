{-# LANGUAGE OverloadedStrings #-}

import qualified AOC


mainA :: IO ()
mainA = do
  ls <- AOC.readFileIntLines "Day01Input"
  print $ foldl countIncreasesA (Nothing, 0) ls

countIncreasesA :: (Maybe Int, Int) -> Int -> (Maybe Int, Int)
countIncreasesA (Nothing, count) current = (Just current, 0)
countIncreasesA (Just prev, count) current =
  if current > prev
    then (Just current, count + 1)
    else (Just current, count)

mainB :: IO ()
mainB = do
  ls <- AOC.readFileIntLines "Day01Input"
  print $ countIncreasesB ls

countIncreasesB :: [Int] -> Int
countIncreasesB ls@(a:b:c:d:_) = do
  let count = if a+b+c < b+c+d then 1 else 0
  (count +) $ countIncreasesB (tail ls)
countIncreasesB _ = 0
