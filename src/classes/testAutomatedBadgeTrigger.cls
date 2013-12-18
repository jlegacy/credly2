@isTest(seeAllData=true)
public with sharing class testAutomatedBadgeTrigger {

	static testMethod void testController() 
	{
        automatedTriggerClass controller = new automatedTriggerClass(); 
	}
	
	static testMethod void testGetSet() 
	{
        automatedTriggerClass controller = new automatedTriggerClass();
        ApexPages.StandardSetController test;
        controller.getBadges(); 
        test = controller.getBadge;
	}
	static testMethod void testMethods() 
	{
        automatedTriggerClass controller = new automatedTriggerClass();
    //  controller.addMemberBadge(accountID, ruleID, badgeID, accountType);
   automatedTriggerClass.addMemberBadge('001i000000NI5twAAD', 'a03i0000007NmtgAAC', 'a01i00000084HQUAA2', 'account');
   automatedTriggerClass.addMemberBadge('003i000000Qv0GiAAJ', 'a03i0000007NmtgAAC', 'a01i00000084HQUAA2', 'contact');
    automatedTriggerClass.addMemberBadge('00Qi0000007QIh4EAG', 'a03i0000007NmtgAAC', 'a01i00000084HQUAA2', 'lead');
     automatedTriggerClass.displayRule('OtherState:STRING|ct|nc~Languages__c:STRING|ct|spanish');
	automatedTriggerClass.lookForHit('test', 'test', 'eq', 'string');
	automatedTriggerClass.lookForHit('test', 'test', 'lt', 'string');
	automatedTriggerClass.lookForHit('test', 'test', 'le', 'string');
	automatedTriggerClass.lookForHit('test', 'test', 'gt', 'string');
	automatedTriggerClass.lookForHit('test', 'test', 'ge', 'string');
	automatedTriggerClass.lookForHit('test', 'test', 'ct', 'string');
	automatedTriggerClass.lookForHit('test', 'test', 'not eq', 'string');
	

	}

}