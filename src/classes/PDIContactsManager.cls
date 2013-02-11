public class PDIContactsManager {

	public PDIContactsManager() {}


	public Contact retrieveContact(String fbid) {
		
		Contact c = [SELECT Id, FirstName, LastName, Email, Birthdate, MailingCity, MailingCountry, FacebookId__c, ProfilePictureLink__c, Gender__c, AccountId, TefAccount__c 
	                 FROM Contact
	                 WHERE FacebookId__c = :fbid];
	             
	    return c;
	}


    public Contact updateContact(FacebookUser fb) {
    	String fbid = fb.id;
    	
    	Contact c = this.retrieveContact(fb.id);

        this.fillContactFields(c, fb);
        
        try {
        	update c;
        		
        } catch (DmlException e) {
        	this.insertContact(fb);
        }
        

        return c;
    }


    public Contact insertContact(FacebookUser fb) {
    	Contact c = new Contact();
    	
	    this.fillContactFields(c, fb);
	    
	    try {
	    	insert c;
	    	
	    } catch (DmlException e) {

	    }
	    
	    return c;
    }


	private void fillContactFields(Contact con, FacebookUser user) {
    	Account acc = this.getFacebookAccount();
    	
    	Date birthdate = this.XMLstringToDate( user.birthday );
        
        String location = user.location.name;
        String city     = location.substringBefore(',');
        String country  = location.substringAfterLast(', ');
    	
	    con.FirstName      = user.first_name;
		con.LastName       = user.last_name;
	    con.Email          = user.email;
	    con.Birthdate      = birthdate;
	    con.MailingCity    = city;
	    con.MailingCountry = country;
	    
	    con.FacebookId__c         = user.id;
	    con.ProfilePictureLink__c = 'https://graph.facebook.com/' + user.id + '/picture?type=normal';
	    con.Gender__c             = user.gender;
	    con.TefAccount__c         = 'none';
	    
	    con.AccountId = acc.id;
	    
    }


	private Account getFacebookAccount() {
		Account acc = null;
		
		try {
    		acc = [SELECT Id FROM Account WHERE name = 'Facebook'];
    		
		} catch (QueryException e) {
			// If there's no any account, then we create a new one
			acc = new Account(Name = 'Facebook');
			insert acc;
		}
		
		return acc;
	}


    private Date XMLstringToDate(String s) {
    	//XML Date String is in the format dd/mm/yyyy
    	String[] stringDate = s.split('/');
        
    	Integer d = Integer.valueOf( stringDate[0] );
    	Integer m = Integer.valueOf( stringDate[1] );
    	Integer y = Integer.valueOf( stringDate[2] );
        
		return date.newInstance(y, m, d);
	}

}