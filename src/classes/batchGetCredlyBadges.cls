global class batchGetCredlyBadges implements 
   Database.Batchable<sObject>,Database.AllowsCallouts {

   global final String query;
   
   global Database.QueryLocator start(Database.BatchableContext BC){
   	  //Query is a dummy does nothing
   	  String query = 'select id from member_badge__c LIMIT 1';
      return Database.getQueryLocator(query);
   }
   
   global void execute(
                Database.BatchableContext BC, 
                List<member_badge__c> scope){
    	
                	getBadges(scope);
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
       mail.setSubject('Member Badge Synch Status: ' + a.Status);
       mail.setPlainTextBody
       ('The batch Apex job processed ' + a.TotalJobItems +
       ' batches with '+ a.NumberOfErrors + ' failures.');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
   
    public void getBadges(List<member_badge__c> scope)
   {
    	 	 String idKey;
	 	 Integer value;
	 	  List < badge__c > currentBadges = [Select lastmodifieddate, credlyBadgeId__c from badge__c];
	 	  Map<String, Integer> foundHitIds = new Map<String, Integer>(); 
        
        //put all current badges in list for lookup 
        for (badge__c y: currentBadges)
        {
             idKey = y.credlyBadgeId__c;
             value = foundHitIds.get(idKey);
             value = (value == null) ? 1 : value + 1;
             foundHitIds.put(idKey,value);
        }
	 	
   String test = CredlyJSONCalls.getCredly(CredlyJSONCalls.getURL()+ 'badges?page=1&per_page=9999&order_direction=ASC' );
   
   String description = ' ';
 List<badge__c> credlyBadges = new List<badge__c>();
 
   Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(test);
     List<Object> dataItems = (List<Object>)m.get('data');
      Integer counter = 0;
      for (Object item : dataItems) {
      	badge__c insertBadges = new badge__c();
        Map<String, Object> i = (Map<String, Object>)item;
        insertBadges.document_id__c = string.valueof(i.get('image_url'));
        
         insertBadges.criteria__c = ''; 
         insertBadges.description__c = ''; 
         insertBadges.expires_in__c = 319999999;  
         insertBadges.is_giveable__c = string.valueof(i.get('is_giveable')); 
         
         if (i.get('short_description')  == null)
         {
         	insertBadges.short_description__c = 'none';	
         }
         else
         {
         	insertBadges.short_description__c = string.valueof(i.get('short_description'));	
         }
         
         insertBadges.title__c = string.valueof(i.get('title'));
         insertBadges.credlyBadgeId__c = string.valueof(i.get('id'));
         
         //lookup badge,if already exists then do not add/synch
         
          idKey = string.valueof(i.get('id'));
          value = foundHitIds.get(idKey);
         
         if (value == null)
         {
         credlyBadges.add(insertBadges);
         }
    }
    	insert credlyBadges;
   }
   
}