interface {
    public tools function init();
    
    public string function encryptEmail(required string email);
    public struct function getFirstPageContext();
    public array function sortArrayOfStructs(required array base, string sortType='text', string sortOrder='ASC', string pathToSubElement='');
}