component{
    this.mappings = {'/org':    expandPath("../icedreaper/system/libs/"),
                     '/system': expandPath("../icedreaper/system/"),
                     '/themes': expandPath("../icedreaper/themes/")};
    
    public any function init(){
    	return this;
    }
}