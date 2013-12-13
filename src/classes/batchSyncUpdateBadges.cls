global class batchSyncUpdateBadges implements 
   Database.Batchable<sObject>,Database.AllowsCallouts {

   global final String query;
   
   global Database.QueryLocator start(Database.BatchableContext BC){
   	 
   	  String query = 'select id, credlyBadgeId__c from badge__c';
      return Database.getQueryLocator(query);
   }
   
   global void execute(
                Database.BatchableContext BC, 
                List<badge__c> scope){
    	
                	updBadges(scope);
   }
   
   global void finish(Database.BatchableContext BC){
       AsyncApexJob a = 
           [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
            TotalJobItems, CreatedBy.Email, ExtendedStatus
            FROM AsyncApexJob WHERE Id =
            :BC.getJobId()];
                          
       // Send an email to the Apex job's submitter 
       //   notifying of job completion. 
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {a.CreatedBy.Email};
       mail.setToAddresses(toAddresses);
       mail.setSubject('Badge Synch Update Status: ' + a.Status);
       mail.setPlainTextBody
       ('The batch Apex job processed ' + a.TotalJobItems +
       ' batches with '+ a.NumberOfErrors + ' failures.');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
   
    public void updBadges(List<badge__c> scope)
   {
    	
	 	 String securityToken;
	 	 String returnData;
	 	 String idKey;
	 	 String test;
	 	 
 		 securityToken = CredlyJSONCalls.authenticate(CredlyJSONCalls.getURL() + 'authenticate');
 	
        //put all current badges in list for lookup 
       Integer count = 0;
       for (badge__c badge : scope) {
        {
             idKey = badge.credlyBadgeId__c;
             returnData = CredlyJSONCalls.getCredly(CredlyJSONCalls.getURL()+  'badges/' + idKey );
          //parseResults
         	CredlyJSON2ApexErrors obj = CredlyJSON2ApexErrors.parse(returnData);
     		if (obj.meta.status.compareTo('OK') == 0)
     	  	{
     	     CredlyJSON2ApexUpdateBadge obj2 = CredlyJSON2ApexUpdateBadge.parse(returnData);
        } 
}
       }
   }
}