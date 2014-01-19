module Web.Tangle (tangle) where 
import Debug.Print 
import qualified Helper.Functions as Helper
import System.FilePath
import System.Directory
import Prelude hiding (readFile)
import Data.ByteString (readFile)

data Literate = Literate {
    topFile :: FilePath 
    , includes :: [Literate]
    , litText :: [String] 
    , filename :: String 
    }

data Chunk = Chunk {
    name :: String          -- Name of this chunk 
    , scope :: FilePath     -- In which file 
    , start :: Int          -- start line 
    , end :: Int            -- Line at which this chunk ends  
    , chunks :: [Chunk]     -- Do we have more chunks embed
    , text :: [String]      -- Text of the chunk 
    , writeTo :: FilePath   -- Write to this file.
    }

readLiterateFile filePath = do 
    res <- doesFileExist filePath
    if res then readFile filePath 
    else error $ "Can't open file : " ++ filePath
            
{- Merge included files in noweb file -}
mergeFiles fileText lit = Helper.getIncludeFiles fileText 

tangle filePath options = do
    litText <- readLiterateFile filePath 
    let mainChunk = mergeFiles litText (Literate filePath [] [] (takeFileName filePath)) 
    putStrLn $ show mainChunk
    infoPrint "Tangling over!"



