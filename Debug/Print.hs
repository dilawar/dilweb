module Debug.Print (coloredPrint, Color
    , ColorIntensity
    , colorStrLn
    , debugPrint 
    , warnPrint 
    , infoPrint 
    , errorPrint ) 
where 

import System.Console.ANSI
 
colorStrLn :: ColorIntensity -> Color -> ColorIntensity -> Color -> String -> IO ()
colorStrLn fgi fg bgi bg str = do
  setSGR [SetColor Foreground fgi fg, SetColor Background bgi bg]
  putStr str
  setSGR []
  putStrLn ""

coloredPrint fg bg str = colorStrLn Vivid fg Dull bg str
debugPrint  str = putStr  "[DEBUG] : " >>  coloredPrint White Black str
warnPrint   str = putStr  "[WARN ] : " >>  coloredPrint Green Black str 
infoPrint   str = putStr  "[INFO ] : " >>  coloredPrint Blue Black str 
errorPrint  str = putStr  "[ERROR] : " >>  coloredPrint Red Black str

