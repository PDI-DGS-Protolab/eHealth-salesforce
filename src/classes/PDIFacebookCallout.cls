public class PDIFacebookCallout {
   
	public PDIFacebookCallout() {}
    
       
    @future(callout=true)
    public static void getUserInfo(String token) {
        String stoken = FacebookCrypto.decrypt(token);
        FacebookUser user = new FacebookUser(stoken, 'me');
        
		PDIContactsManager cm = new PDIContactsManager();

		try {
			// The contact already existed on the database
			cm.updateContact(user);
			
		} catch (System.QueryException e) {		// Creating a new contact
			cm.insertContact(user);
		}
		
	}


}