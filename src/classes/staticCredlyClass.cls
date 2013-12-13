public with sharing class staticCredlyClass {
	
	static public String getToken()
	{
		String token = null;
		token_data__c[] myToken = [SELECT user_name_t__c, token_data_t__c FROM token_data__c WHERE user_name_t__c = :UserInfo.getUserId()];
	    for (token_data__c a : myToken)
	    {
		token = a.token_data_t__c;
	    }
	     
	    return token;
	   }
	static public void setToken(String x)
	{
	    //delete token
	    token_data__c[] myToken = [SELECT user_name_t__c, token_data_t__c FROM token_data__c WHERE user_name_t__c = :UserInfo.getUserId()];
	    try{
	    delete myToken;
	    	} catch (DmlException e) {
    // Process exception here
			}
	    
	    
	    //create new one
	    token_data__c newToken = new token_data__c(user_name_t__c = UserInfo.getUserId(), token_data_t__c = x);
		myToken.add(newToken);
	 
		try {
    		insert myToken;
			} catch (DmlException e) {
    // Process exception here
			}
	   	 
	}
		static public PageReference tokenPage()
	{
		return Page.ViewBadgeToken;
	}
	   
}