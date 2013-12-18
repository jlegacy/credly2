global class batchSyncUpdateBadges implements 
   Database.Batchable<sObject>,Database.AllowsCallouts {

   global final String query;
   
   global Database.QueryLocator start(Database.BatchableContext BC){
   	
   	  String query = 'select credlyBadgeId_x__c from chg_badge__c';
      return Database.getQueryLocator(query);
   }
   
   global void execute(
                Database.BatchableContext BC, 
                List<chg_badge__c> scope){
    	
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
   
    public void updBadges(List<chg_badge__c> scope)
   {
    	
	 	 String securityToken;
	 	 String returnData;
	 	 String idKey;
	 	 String test;
	 	 Datetime dt1;
	 	 Datetime dt2;
	 	 
 		 securityToken = CredlyJSONCalls.authenticate(CredlyJSONCalls.getURL() + 'authenticate');
 	
        //put all current badges in list for lookup 
       Integer count = 0;
       for (chg_badge__c badge : scope) {
        {
          //get badge
          
             idKey = badge.credlyBadgeId_x__c;
             returnData = CredlyJSONCalls.getCredly(CredlyJSONCalls.getURL()+  'badges/' + idKey );
          //parseResults
         	CredlyJSON2ApexErrors obj = CredlyJSON2ApexErrors.parse(returnData);
     		if (obj.meta.status.compareTo('OK') == 0)
     	  	{
     	     CredlyJSON2ApexUpdateBadge obj2 = CredlyJSON2ApexUpdateBadge.parse(returnData);
        	 badge__c getBadge = [select LastModifiedDate from badge__c where credlyBadgeId__c = :badge.credlyBadgeId_x__c];
        	// Datetime myDate = convertSFdate(getBadge.LastModifiedDate);
        //	 dt1 = Datetime.parse(getBadge.LastModifiedDate);
        	 dt1 = Datetime.valueOf(getBadge.LastModifiedDate); 
        	 dt2 = Datetime.valueOf(staticCredlyClass.convCRDateTime(obj2.data.creator.updated_at));
        	//  dt2 = dt2.newInstance(obj2.data.creator.updated_at);
        	 system.debug(dt1);
        	 system.debug(dt2);
        	 system.debug(getBadge.LastModifiedDate);
        	  system.debug(obj2.data.creator.updated_at);
        	}
          //update badge
           
}
       }
   }
}