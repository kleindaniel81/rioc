*! version 1.0.2  16jul2026
program rioci
    
    version 11.2
    
    syntax anything(id = "integer") [ , noTab replace * ]
    
    gettoken a anything : anything , parse(" \")
    gettoken b anything : anything , parse(" \")
    gettoken c anything : anything , parse(" \")
    gettoken d anything : anything , parse(" \")
    
    if ("`c'" == "\") {
        
        local c `d'
        gettoken d anything : anything
        
    }
    
    if (`"`anything'"' != "") ///
        error 198
    
    preserve
    
    quietly {
        
        tabi `a' `b' \ `c' `d' , replace
        
        replace row = 2 - row
        replace col = 2 - col
        
        rename row prediction
        rename col    outcome
        
        label variable prediction "Prediction"
        label variable    outcome    "Outcome"
        
    }
    
    if ("`tab'" != "notab") ///
        local tab tab
    
    rioc prediction outcome [fweight = pop] , `tab' `options'
    
    if ("`replace'" == "replace") ///
        restore , not
    
end


exit


/*  _________________________________________________________________________
                                                              Version history

1.0.2   16jul2026   bug fix: insert missing comma in `restore , not`
                    unroll loop for parsing for increased readability
1.0.1   16may2025   code polished
1.0.0   26jan2021