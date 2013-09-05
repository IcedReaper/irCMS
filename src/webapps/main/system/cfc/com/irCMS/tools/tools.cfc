component  implements="system.interfaces.com.irCMS.tools" {
    public tools function init() {
        return this;
    }
    
    public array function sortArrayOfStructs(required array base, string sortType="text", string sortOrder="ASC", string pathToSubElement) {
        var tmpStruct = {};
        var returnVal = [];
        
        for(var i = 1; i <= arrayLen(arguments.base); i++) {
            tmpStruct[i] = arguments.base[i];
        }
        
        var keys = StructSort(tmpStruct, arguments.sortType, arguments.sortOrder, arguments.pathToSubElement);
        
        for(i = 1; i <= arrayLen(keys); i++) {
            returnVal[i] = tmpStruct[keys[i]];
        }
        
        return returnVal;
    }
    
    public struct function getFirstPageContext() {
        // this is the 'local' page context
        var out = getPageContext().getOut();
        // iterate over this to catch the parent object until we get to a coldfusion.runtime.NeoJspWriter
        while (getMetaData(out).getName() == 'coldfusion.runtime.NeoBodyContent'){
            out = out.getEnclosingWriter();
        }
        return out;
    }
    
    public string function encryptEmail(required string eMail) {
        var result = '';
        for(var i = 1; i <= Len(arguments.eMail); i++) {
            result = result & "&##" & asc(mid(arguments.eMail, i, 1)) & ";";
        }
        
        return result;
    }
}