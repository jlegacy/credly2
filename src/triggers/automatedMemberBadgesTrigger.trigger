trigger automatedMemberBadgesTrigger on member_badge__c (before insert, before update) {
	for (member_badge__c c : Trigger.new)
	{
		 String returnData;
	String securityToken;
	String encodedImage;
	String createURL;
	String[] splitName = null;
	String email;
	}
	}