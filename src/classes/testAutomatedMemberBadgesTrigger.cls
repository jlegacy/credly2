@isTest(seeAllData=true)
public with sharing class testAutomatedMemberBadgesTrigger {
	
	//Update member badge
	static testMethod void testUpdateMemberBadge() 
	{
	member_badge__c updateMember = [select id from member_badge__c where credlyMemberBadge_id_m__c = 1428];
	updateMember.description_m__c = 'test';
	update updateMember;
	}

}