public class PDIFacebookCallout {
    
	public PDIFacebookCallout() {}
    
    @future(callout=true)
    public static void getUserInfo(String token) {
              
        String stoken = FacebookCrypto.decrypt(token);
        FacebookUser user = new FacebookUser(stoken, 'me');
        
        Account acc = [SELECT Id FROM Account WHERE name = 'Facebook'];
        
        Contact testContact = new Contact(
            FirstName = user.first_name,
            LastName  = user.last_name,
            Email     = user.email,
            AccountId = acc.Id
        );
        
 		insert testContact;
    }
    
}