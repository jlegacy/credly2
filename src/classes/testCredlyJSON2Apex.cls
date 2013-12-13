@isTest(seeAllData=true)
public with sharing class testCredlyJSON2Apex {
	
	static testMethod void testMethods() 
	{
	     CredlyJSON2Apex controller = new CredlyJSON2Apex(); 
	     CredlyJSON2Apex.Meta testMeta = new CredlyJSON2Apex.Meta();
	     testMeta.message = 'test';
	     testMeta.status = 'test';
	     testMeta.status_code = 1;
	     CredlyJSON2Apex.parse('{"meta":{"status_code":200,"status":"OK","message":"","more_info":null},"data":1412}');
	     
	}

}