public with sharing class BadgeTokenController {
	
	    public String token{get;set;}
	   
	   public BadgeTokenController() { 
	    	
		token = staticCredlyClass.getToken(); 
	   }
	   public PageReference saveToken()
	   {
	    staticCredlyClass.setToken(token); 
	   	return null;
	   }

}