component {
    public module function init(required string datasource, required string tablePrefix);
    
    public array function searchByTag(required string tagName);
    public array function searchByHeadline(required string headline);
    public array function search(required textPart);
}
