import System.Environment
import System.Exit
import System.Console.GetOpt
import System.FilePath 
import Data.Maybe

type Command = String
data Flag = Version | Input FilePath | Web Command  deriving Show

options :: [OptDescr Flag]
options = [
    Option ['V'] ["version"] (NoArg Version)            "show version number",
    Option ['i'] ["input"]   (ReqArg Input "file")      "path to literate file",
    Option ['c'] ["command"]  (ReqArg Web "tangle | weave")       "which command to run"
  ]

compilerOpts argv =
   case getOpt RequireOrder options argv of
      (flags, [], []) -> tangleOrWeave flags 
      (_, nonOpts, []) -> error $ "Unknown option(s) " ++ unwords nonOpts
      otherwise -> error "Error"
  where header = "\nUsage: "

tangleOrWeave opts = case opts of
    [(Input filePath)] -> mergeFileAndExecute filePath ""
    [(Input filePath), (Web command)] -> mergeFileAndExecute filePath command 

mergeFileAndExecute filePath command =
    putStrLn $ "Processing " ++ filePath

main = do
  getArgs >>= compilerOpts 
  putStrLn "Done"
