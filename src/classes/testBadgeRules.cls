@isTest(seeAllData=true)
public with sharing class testBadgeRules {
static testMethod void testController() 
	{
        viewBadgeRulesController controller = new viewBadgeRulesController(); 
	}
	
	static testMethod void getSet() 
	{
        viewBadgeRulesController controller = new viewBadgeRulesController(); 
        controller.addBlock = true;
        controller.criteria = 'test';
        controller.expires_in = '99999';
        controller.getRuleField1 = 'test'; 
	}
	
static testMethod void testMethods() 
	{
        viewBadgeRulesController controller = new viewBadgeRulesController(); 
        ApexPages.StandardSetController getBadge;
         ApexPages.StandardSetController getRule;
        controller.setVisibleStep(1);
        controller.setVisibleStep(2);
        controller.setVisibleStep(3);
        controller.setVisibleStep(4);
        controller.setVisibleStep(5);
        
        controller.nextStep();
        controller.nextStep();
        controller.nextStep();
        controller.nextStep();
        controller.nextStep();
        
        controller.backStep();
        
        controller.xBadgeId = 'a03i0000007NmtgAAC';
        controller.xRuleId = 'a03i0000007NmtgAAC';
        controller.modify();
        controller.deleteBadgeRuleController();
        controller.reloadFields();
        
        controller.getDropBadges();
        controller.closeBadge();
        
        controller.filterBadge = '';
        getBadge = controller.getBadge;
        
          controller.filterBadge = 'test';
        getBadge = controller.getBadge;
        
        controller.getOperandTypes();
        controller.getRecordTypes();
        
        controller.hideUpload();
        
        controller.addBadge();
        
        controller.filterBadgeSearch = 'test';    
        
        controller.searchBadge();
        getRule = controller.getRule;
        
        controller.getRules();
        
        controller.getFields('account');
        controller.getFields('lead');
         controller.getFields('contact');
        
        controller.setRuleText = 'Languages__c:STRING|eq|spanish~IsDeleted:BOOLEAN|eq|false';
        controller.setBadgeSelect = 'a03i0000007NmtgAAC';
        
          controller.name = 'testing';
    
        controller.testimonial = 'testing';
         controller.emailChecked = true;
        controller.populateRecordType = 'contact';
         controller.customMessage = 'testing';


 			controller.xRuleId = 'a03i0000007NmtgAAC';  
 			controller.upload();   
 			
 			controller.xRuleId = '';  
 			controller.upload(); 
 			
 			controller.getPopulateRecordType();
 			controller.setRuleEmpty();
 			controller.deleteRuleDetail();
 			controller.getBadges();
 			controller.setTestimonialEmpty();
 			controller.setBadgeIdEmpty();
 			controller.renderPage();
 						     
        
	}


}