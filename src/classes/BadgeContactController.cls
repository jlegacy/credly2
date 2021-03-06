public with sharing class BadgeContactController {
    
      public BadgeContactController() { 

		getOnce = true;
        renderStep1 = true;
        renderStep2 = false;
        renderStep3 = false;
        renderStep4 = false;
        renderStep5 = false;
        renderAccounts = false;
        renderLeads = false;
        renderContacts = false;
        step = 1;
        emailChecked = true;
       
        xRecordType = '';
        xSelectedIDs = '';
        setBadgeSelect = '';
        setTestimonialSelect = '';
        filterName = '';
        filterBadge = '';
          String returnData;
          
         securityToken = CredlyJSONCalls.authenticate(CredlyJSONCalls.getURL() + 'authenticate');   
    }
    
    public List < badge__c > badgeList {get;set;}
     public String securityToken {get; set;}
     public Boolean getOnce {get; set;}
    
    public Boolean emailChecked {get; set;}
     public Boolean customMessageChecked {get; set;}
       public String customMessage {get; set;}
       public String urlLink {get; set;}
       public Integer recipientNumber {get; set;}
    

 
   public String setBadgeSelectTitle {get; set;}
   
    public void setTestimonialEmpty() {
     
    }
    
      public void backStep() { 
        //if you are on step 3 and going back to step 2, then 
        //the select recipients screen needs to rerender
        
        step = step - 2;
        nextStep();
      } 
    
      public PageReference nextStep() { 
        step = step + 1;
        
            if (step == 1)
        {
            renderStep1 = true;
            renderStep2 = false;
            renderStep3 = false;
            renderStep4 = false;
            renderStep5 = false;
            renderAccounts = false;
            renderLeads = false;
            renderContacts = false;
        }
        if (step == 2)
        {
        if (setBadgeSelect.trim().length() == 0) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Need to Select a Badge'));
            nextStep();
            return null;
        }
            
            if (xSelectedIDs.trim().length() == 0)
            {
            renderStep1 = false;
            renderStep2 = true;
            renderStep3 = false;
            renderStep4 = false;
            renderStep5 = false;
                
            }
            else
            {
                renderPage();
            }
            
        }
            if (step == 3)
        {
            showUploadOnly();
        }
        
            if (step == 4)
        {
            showReview();
        }
        
            if (step == 5)
        {
            showConfirm();
        }
        
        return null;
    }

    public PageReference setBadgeIdEmpty() {
        
        //select id from badge and set fields//
        String i = setBadgeSelect;
        List < badge__c > bd = [Select Id, title__c, image__c, credlyBadgeId__c from badge__c where ID = : i LIMIT 1];
        for (badge__c y: bd)
        {
        setBadgeSelectTitle = y.title__c;
        }
        return null;
    }
    
    
    public Integer step {get; set;}
    
    public String setBadgeSelect { get; set; }
    
    public String setBadgeSelectImage { get; set; } 
    
        public Boolean renderTestimonial { 
        get;
        set;
    }
    
     public Boolean renderStep1 {
        get;
        set;
    }
    public Boolean renderStep2 {
        get;
        set;
    }
      public Boolean renderStep3 {
        get;
        set;
    }
    
       public Boolean renderStep4 {
        get;
        set;
    }
       public Boolean renderStep5 {
        get;
        set;
    }
    
 
  
    public void captureChecks() {

    }


    public String getCheckIt() {

        return null;
    }


    public PageReference showUploadOnly() {
    	
    	String email;

        if ((xSelectedIDs == null) || (xSelectedIDs.trim().length() <= 2)) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Select Either Accounts, Contacts, or Leads'));
             renderStep1 = false;
            renderStep2 = true;
            renderStep3 = false;
            renderStep4 = false;
            renderStep5 = false;
        
            return null;
        }
        
        
         //loop through selected ids//
          if ((xSelectedIDs != null) || (xSelectedIDs.trim().length() > 2)) {
          	 String[] temp = null;
            temp = xSelectedIDs.split(',');
            
             for (String i : temp) {
             
           if (i.length() > 1)
           {
           	email = (sendEmail.getEmailAddress(i, xRecordType) != null) ? sendEmail.getEmailAddress(i, xRecordType) : ' ';  
           	if (email.compareTo(' ') == 0)
           	{
           	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Selected Accounts, Contacts, or Leads Must Have an Email Address'));
            renderStep1 = false;
            renderStep2 = true;
            renderStep3 = false;
            renderStep4 = false;
            renderStep5 = false;
        
            return null;
           		
           	}
           }
           }
           
        }
          
           
        
        renderStep1 = false;
        renderStep2 = false;
        renderStep3 = true;
        renderStep4 = false;
        renderStep5 = false;
      

        renderLeads = false;
        renderAccounts = false;
        renderContacts = false;
        
        step = 3;
        
        return null;

    }
    
       public void showReview() {

        String[] temp  = xSelectedIDs.split(',');
        recipientNumber = temp.size();
          
          
        renderStep1 = false;
        renderStep2 = false;
        renderStep3 = false;
        renderStep4 = true;
        renderStep5 = false;
      
        renderLeads = false;
        renderAccounts = false;
        renderContacts = false;

    }
    
       public void showConfirm() {

       
        renderStep1 = false;
        renderStep2 = false;
        renderStep3 = false;
        renderStep4 = false;
        renderStep5 = true;
      
        renderLeads = false;
        renderAccounts = false;
        renderContacts = false;
       
    }
    
    
     public badge__c badge{get;set;}

    public Boolean renderFilters {
        get;
        set;
    }

    public Boolean renderBadges {
        get;
        set;
    }

    public Boolean renderUpload {
        get;
        set;
    }


    public PageReference createMemberBadgesApex() {

        return null;
    }

    public String xRecordType {
        get;
        set;
    }

    public String xSelectedIDs {
        get;
        set;
    }

    public Boolean uploadRendered {
        get;
        set;
    }

    public Boolean renderAccounts {
        get;
        set;
    }
    
     public Boolean renderLeads {
        get;
        set;
    }
    
    public String setTestimonialSelect{get;set;}
        

    public Boolean renderContacts {
        get;
        set;
    }

  
     public PageReference searchBadge() {
          getBadges();
        return null;
     }
     
    public PageReference renderPage() {
        
        renderStep1 = false;
        renderStep2 = true;
        renderStep3 = false;
        renderStep4 = false;
        renderStep5 = false;
        
        renderAccounts = false;
        renderContacts = false;
        renderLeads = false;

        if (recordType == 'Account') {
            renderAccounts = true;
            getAccount = null;
            getAccounts();
        }
        if (recordType == 'Contact') {
           renderContacts = true;
            getContact = null;
            getContacts();
        }
         if (recordType == 'Lead') {
           renderLeads = true;
            getLead = null;
            getLeads();
        }
        
        
        return null;

    }

    public List < SelectOption > getRecordTypes() {
        List < SelectOption > options = new List < SelectOption > ();
        options.add(new SelectOption('Account', 'Account'));
        options.add(new SelectOption('Contact', 'Contact'));
         options.add(new SelectOption('Lead', 'Lead'));
        return options;
    }

    public String filterName {
        get;
        set;
    }

    public String filterNameSearch {
        get {
            return '%' + filterNameSearch + '%';
        }

        set {
            filterNameSearch = filterName;
        }

    }
    
     public String filterBadge {
        get;
        set;
    }

    public String filterBadgeSearch {
        get {
            return '%' + filterBadgeSearch + '%';
        }

        set {
            filterBadgeSearch = filterBadge;
        }

    }
    public String recordType {
        get;
        set;
    }
    public String short_description {
        get;
        set;
    }
    public String description {
        get;
        set;
    }
    public String criteria {
        get;
        set;
    }
    public String is_giveable {
        get;
        set; 
    }
    public Integer expires_in {
        get;
        set;
    }
    public Boolean addBlock {
        get;
        set;
    }
    public Boolean detailsBlock {
        get;
        set;
    }
    public String title {
        get;
        set;
    }
    
    
    public PageReference closeBadge() {

        addBlock = false;
        detailsBlock = true;

        PageReference pageRef = new PageReference('/apex/ViewBadges');
        pageRef.setRedirect(true);
        return pageRef;
    }


    public List < SelectOption > getDropBadges() {
		system.debug('drop badges');
        List < badge__c > newBadges = getBadges();


        List < SelectOption > options = new List < SelectOption > ();
          options.add(new SelectOption('', ''));
        for (badge__c c: newBadges) {
            options.add(new SelectOption(c.id, c.title__c + ' - ' + c.short_description__c));
        }
        
       

        return options;
    }


    public String getSelectedItem() {
        return null;
    }

    public Document document {
        get {
            if (document == null)
                document = new Document();
            return document;
        }
        set;
    }
     
    public String GetName(String type, String i)
    {
         String name = null;
         
         if (type.equals('contact'))
        {
        List < Contact > cn = [Select Id, FirstName, LastName from contact where ID = : i LIMIT 1];
        for (Contact y: cn)
        {
        name = y.LastName + ',' + y.FirstName;
        }
        }
        
        if (type.equals('account'))
        {
        List < Account > ac = [Select ID, Name from account where ID = : i LIMIT 1];
        for (Account x: ac)
        {
        name = x.Name;
        }
        }
        
        
         if (type.equals('lead'))
        {
        List < Lead > ld = [Select ID, FirstName, LastName from lead where ID = : i LIMIT 1];
        for (Lead x: ld)
        {
        name = x.LastName + ',' + x.FirstName;
        }
        }
        
  
    return name;
    
    }

    public PageReference upload() {

		String encodedImage;
		String xbadgeURL = '';
		String strBody;
		String returnData;
		String createURL;
		 String errMessage;
  		String stsMessage;
  		String[] splitName = null;
  		String email = ' ';

        if (document.body != null) {
            document.AuthorId = UserInfo.getUserId();
            document.FolderId = UserInfo.getUserId(); 
            strBody = EncodingUtil.base64Encode(document.body);
              try {
            insert document;

        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading file'));
            return null;
        }
        }

        try {
        
        
        //get original base badge
        
         badge = [Select Id, criteria__c, description__c, document_id__c,
         expires_in__c, image__c,is_giveable__c, short_description__c,
         title__c,credlyBadgeId__c, categories__c from badge__c where ID = : setBadgeSelect LIMIT 1];

  		 List<member_badge__c> memberBadgeList = new List<member_badge__c>();
         //loop through selected ids//
           String[] temp = null;
            temp = xSelectedIDs.split(',');
            
             for (String i : temp) {
             
           if (i.length() > 1)
           {
      
         member_badge__c memberBadge = new member_badge__c();
         
        memberBadge.criteria_m__c = badge.criteria__c;
         memberBadge.description_m__c = badge.description__c;
          memberBadge.document_id_m__c = badge.document_id__c;
           memberBadge.expires_in_m__c = badge.expires_in__c;
           memberBadge.badge_lookup_m__c = setBadgeSelect;
           memberBadge.categories_m__c = badge.categories__c;
           memberBadge.is_visible_m__c = 'true';
           
             memberBadge.is_giveable_m__c = badge.is_giveable__c;
              memberBadge.short_description_m__c = badge.short_description__c;
              memberBadge.title_m__c = badge.title__c;
              memberBadge.lookup_id_m__c = i;
              
                if (xRecordType == 'account')
                {
                memberBadge.account_lookup_m__c = i;
                }
                  if (xRecordType == 'contact')
                {
                memberBadge.contact_lookup_m__c = i;
                }
                 if (xRecordType == 'lead')
                {
                memberBadge.lead_lookup_m__c = i;
                }
                
                memberBadge.account_type_m__c = xRecordType;
                
                if (document.body != null)
                {
                 memberBadge.evidence_id_m__c = document.Id;
                 memberBadge.evidence_name_m__c = document.Name;
                }
                else
                {          
                 memberBadge.evidence_url_m__c = urlLink;
                }
             
                 memberBadge.testimonial_m__c = setTestimonialSelect;
                 
                 memberBadge.name_m__c = getName(xRecordType, i);
                 
                 memberBadge.issue_date_m__c = system.today();
           insert memberBadge;
           memberBadgeList.add(memberBadge);
               
             }
               }
               
        
            //  system.debug(xRecordType);
            //   system.debug(emailChecked);
           if (emailChecked)
            {
          	for(member_badge__c a : memberBadgeList){
          	sendEmail.sendEmail(a.lookup_id_m__c, a.Id, xRecordType);
			}
          
            }
          
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error creating Member Badge.'));
            return null;
        } finally {
            document.body = null; // clears the viewstate
            document = new Document();
        }

        nextStep();

       // ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Member Badge Successfully Created'));

        return null;
    }


    public ApexPages.StandardSetController getContact {

        get {
            if (getContact == null) {


                if ((filterName == null) || (filterName.trim().length() == 0)) {
                    getContact = new ApexPages.StandardSetController(Database.getQueryLocator(
                        [SELECT Name,email, ID from Contact]));
                } else {
                    filterNameSearch = filterName;
                    getContact = new ApexPages.StandardSetController(Database.getQueryLocator(
                        [SELECT Name,email, ID from Contact where Name like: filterNameSearch]));
                }

            }
            return getContact;
        }
        set;
    }
    
     public ApexPages.StandardSetController getLead {

        get {
            if (getLead == null) {


                if ((filterName == null) || (filterName.trim().length() == 0)) {
                    getLead = new ApexPages.StandardSetController(Database.getQueryLocator(
                        [SELECT Name,email, ID from Lead]));
                } else {
                    filterNameSearch = filterName;
                    getLead = new ApexPages.StandardSetController(Database.getQueryLocator(
                        [SELECT Name,email, ID from Lead where Name like: filterNameSearch]));
                }

            }
            return getLead;
        }
        set;
    }

    // Initialize setCon and return a list of records
    public List < Contact > getContacts() {
        return (List < Contact > ) getContact.getRecords();
    }
    
      // Initialize setCon and return a list of records
    public List < Lead > getLeads() {
        return (List < Lead> ) getLead.getRecords();
    }

    public ApexPages.StandardSetController getAccount {
        get {
            if (getAccount == null) {


                if ((filterName == null) || (filterName.trim().length() == 0)) {
                    getAccount = new ApexPages.StandardSetController(Database.getQueryLocator(
                      //  [SELECT Name, ID from Account]));
                      [SELECT Name,ID, (SELECT email FROM Account.Contacts LIMIT 1) FROM Account]));
                } else {
                    filterNameSearch = filterName;
                    getAccount = new ApexPages.StandardSetController(Database.getQueryLocator(
                        [SELECT Name, ID from Account where Name like: filterNameSearch]));
                }

            }
      //      system.debug(getAccount);
            return getAccount;
        }
        set;
    }

    // Initialize setCon and return a list of records
    public List < Account > getAccounts() {
        return (List < Account > ) getAccount.getRecords();
    }

    public ApexPages.StandardSetController getBadge {
        get {
            //  system.debug(filterBadge);
            
               if (((filterBadge != null) || (filterBadge.trim().length() != 0))) 
               {
               filterBadgeSearch = filterBadge;
                getBadge = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [select id,criteria__c, description__c, expires_in__c, is_giveable__c, short_description__c, title__c, image__c, document_ID__c,credlyBadgeId__c  from badge__c where title__c like :filterBadgeSearch]));
            }
            
            if (((filterBadge == null) || (filterBadge.trim().length() == 0))) 
            {
              getBadge = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [select id,criteria__c, description__c, expires_in__c, is_giveable__c, short_description__c, title__c, image__c, document_ID__c,credlyBadgeId__c  from badge__c]));
            }
               
            return getBadge;
        }
        set;
    }

    // Initialize getBadge and return a list of records
    
    public List < badge__c > getBadges() {
    	if (badgeList == null)
    	{
    		badgeList = getBadge.getRecords();
    	}
    	return badgeList;
    }




}