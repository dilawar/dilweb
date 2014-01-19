module Helper.Functions where 

import Data.ByteString.Char8

-- Get all files which are included in this file.
getIncludeFiles text = helper (split '\n' text) 
    where helper lines = lines
