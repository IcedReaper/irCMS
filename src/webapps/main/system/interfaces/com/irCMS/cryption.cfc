interface {
    public cryption function init(required string structSeparator);
    
    public string function encrypt(required string rawData);
    public string function decrypt(required string encryptedData);
    
    public string function encryptStruct(required struct rawData);
    public struct function decryptStruct(required strinf encryptedData);
}