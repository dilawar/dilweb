import System.Environment
import System.Console.GetOpt
import System.FilePath 
import Data.Maybe
import Web.Tangle 
import Web.Weave
import Debug.Print 

type Command = String
data Flag = Version | Input FilePath | Web Command  deriving Show

options :: [OptDescr Flag]
options = [
    Option ['V'] ["version"] (NoArg Version)         "show version number",
    Option ['i'] ["input"]   (ReqArg Input "file")     "path to literate file",
    Option ['c'] ["command"]  (ReqArg Web "tangle | weave") "which command to run",
    Option ['f'] ["filter"]  (ReqArg Web "filter string")    "any extra command"
  ]

compilerOpts argv =
   case getOpt RequireOrder options argv of
      (flags, [], []) -> tangleOrWeave flags 
      (_, nonOpts, []) -> error $ "Unknown option(s) " ++ unwords nonOpts
      otherwise -> error "Error"
  where header = "\nUsage: "

tangleOrWeave opts = case opts of
    [(Input filePath)] -> execute filePath "" ""
    [(Input filePath), (Web command)] -> execute filePath command ""
    [(Input filePath), (Web command), (Web option)] -> execute filePath command option

execute filepath "tangle" options = tangle filepath options
execute filepath "weave" options = weave filepath options
execute filepath "" options = tangle filepath options
execute filepath _ _ = error "Unknown command"

main = do
  getArgs >>= compilerOpts 
  putStrLn "Done"
