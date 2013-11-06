component  implements="system.interfaces.com.irCMS.tools.cryption" {
    public cryption function init(required string encryptionKey, required string algorithm, required string structSeparator) {
        variables.structSeparator = arguments.structSeparator;
        variables.encryptionKey   = arguments.encryptionKey;
        variables.algorithm       = arguments.algorithm;
        
        return this;
    }
    
    public string function encryptPassword(required string password) {
    	return hash(arguments.password);
    }
    
    public string function encrypt(required string rawString) {
    	return encrypt(string=arguments.rawString, key=variables.encryptionKey, algorithm=variables.algorithm);
    }
    
    public string function decrypt(required string encryptedString) {
        return decrypt(encrypted_string=arguments.encryptedString, key=variables.encryptionKey, algorithm=variables.algorithm);
    }
    
    public string function encryptStruct(required struct rawData) {
    	var stringToEncrypt = "";
    	for(var element in arguments.rawData) {
    		stringToEncrypt &= (stringToEncrypt.length() != 0 ? variables.structSeparator : "") & element & "=" & arguments.rawData[element];
    	}
        return this.encrypt(rawString=stringToEncrypt);
    }
    
    public struct function decryptStruct(required string encryptedData) {
    	var decryptedData = this.decrypt(encryptedString=arguments.encryptedData);
        decryptedData = listToArray(decryptedData, variables.structSeparator);
        
        var structuredData = {};
        for(var i = 1; i <= decryptedData.len(); i++) {
            var varsInfo = listToArray(decryptedData[i], "=");
            structuredData[varsInfo[1]] = varsInfo[2];
        }
        return structuredData;
    }
}