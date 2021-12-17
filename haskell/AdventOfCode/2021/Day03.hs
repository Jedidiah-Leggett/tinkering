{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T

import qualified AOC


mainA :: IO ()
mainA = do
  ls <- AOC.readFileTextLines "Day03Input"
  let binaries = fmap (fmap (read . (:[])) . T.unpack) ls
  let result = foldl (zipWith (+)) (initTracker binaries) binaries
  let gammaBinary = fmap (\ r -> if 2*r > length binaries then 1 else 0) result
  let epsilonBinary = fmap (\ r -> if 2*r < length binaries then 1 else 0) result
  print $ binaryToInt gammaBinary * binaryToInt epsilonBinary
  where
    initTracker :: [[Int]] -> [Int]
    initTracker = flip take (repeat 0) . length . head

binaryToInt :: [Int] -> Int
binaryToInt binary = binaryToInt' 0 $ reverse binary
  where
    binaryToInt' _ [] = 0 
    binaryToInt' p (b:ls) = (b*2 ^ p) + binaryToInt' (p+1) ls
