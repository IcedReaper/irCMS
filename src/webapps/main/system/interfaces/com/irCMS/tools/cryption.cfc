interface {
    public cryption function init(required string encryptionKey, required string algorithm, required string structSeparator);
    
    public string function encryptPassword(required string password);
    public string function encrypt(required string rawString);
    public string function decrypt(required string encryptedString);
    
    public string function encryptStruct(required struct rawData);
    public struct function decryptStruct(required string encryptedData);
}