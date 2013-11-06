component extends="mxunit.framework.TestCase" {
    public void function beforeTests() {
        variables.cryptionAPI = createObject("component", "system.cfc.com.IcedReaper.cms.tools.cryption").init(encryptionKey   = 'ircms_s3cur1ty_key_f0r_3ncrypt10n'
                                                                                                              ,algorithm       = 'AES'
                                                                                                              ,structSeparator = ';');
    }
    
    public void function afterTests() {
        
    }
    
    public void function setup() {
        
    }
    
    public void function teardown() {
        
    }
    
    public void function encryptTest_WithSimpleString() {
    	var str = 'test';
    	debug(variables.cryptionAPI.encrypt(str));
    	assertEquals(str, variables.cryptionAPI.decrypt(variables.cryptionAPI.encrypt(str)));
    }
    
    public void function encryptTest_WithComplexString() {
        var str = 'testÄnú124$")^°';
        assertEquals(str, variables.cryptionAPI.decrypt(variables.cryptionAPI.encrypt(str)));
    }
    
    public void function encryptTest_WithSimpleStruct() {
        var myStruct = {};
        myStruct.key1 = "Hallo Welt";
        myStruct.key2 = "Dies ist eine Geschichte";
        myStruct.key3 = "von unvorstellbarer Größe.";
        myStruct.key4 = "Sie betrifft die ganze Menschheit";
        myStruct.key5 = "in Ihrer über Jahrhunderte definierten";
        myStruct.key6 = "Demokratischen Grundrechte auf Freiheit in jeglicher Form.";
        
        var myDecryptedStruct = variables.cryptionAPI.decryptStruct(variables.cryptionAPI.encryptStruct(myStruct));
        assertEquals(myStruct.key1, myDecryptedStruct.key1);
        assertEquals(myStruct.key2, myDecryptedStruct.key2);
        assertEquals(myStruct.key3, myDecryptedStruct.key3);
        assertEquals(myStruct.key4, myDecryptedStruct.key4);
        assertEquals(myStruct.key5, myDecryptedStruct.key5);
        assertEquals(myStruct.key6, myDecryptedStruct.key6);
    }
}