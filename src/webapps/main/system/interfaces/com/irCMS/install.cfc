interface {
    public install function init(required string datasource, required string tablePrefix);
    
    public boolean function theme(required string themeName);
    public boolean function user(required string userName, required string userEmail);
    public boolean function error();
    public boolean function menu();
    public boolean function permission();
}