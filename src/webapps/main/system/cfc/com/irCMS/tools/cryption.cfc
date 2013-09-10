component  implements="system.interfaces.com.irCMS.cryption" {
    public cryption function init(required string structSeparator) {
        variables.structSeparator = arguments.structSeparator;
        
        return this;
    }
    
    public string function encrypt(required string rawData) {
        return arguments.rawData;
    }
    
    public string function decrypt(required string encryptedData) {
        return encryptedData;
    }
    
    public string function encryptStruct(required struct rawData) {
        return "";
    }
    
    public struct function decryptStruct(required strinf encryptedData) {
        return {};
    }
}