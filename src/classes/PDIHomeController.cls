public class PDIHomeController extends FacebookLoginController {
	
	/* BEGIN Code copied from FacebookSampleController */
	
	private static String authProviderId = null;

	public String message {get; set;}
	public String postId {get; set;}
	public String userData {get; set;} 
	public String error {get; set;}
	
	public PDIHomeController() {
		userData = 'null';
	}


	public override PageReference login() {
		return ( authProviderId == null ) ? super.login() : null;
	}
	
	
    public static String getAccessToken() {
    	return ( authProviderId == null ) 
    		? FacebookToken.getAccessToken()
    		: Auth.AuthToken.getAccessToken(authProviderId, 'facebook');
    }


	public FacebookUser me {
		get {
			try {
				// Can't set up 'me' in the controller constructor, since the superclass
				// 'login' method won't have been called!
				if (me == null) {
					String accessToken = getAccessToken();
					
					// If accessToken is null, it's likely that the page's action 
					// method has not yet been called, so we haven't been to FB to
					// get an access token yet. If this is the case, we can just 
					// leave 'me' as null, since the redirect will happen before
					// HTML is send back.
					if (accessToken != null) {
						me = new FacebookUser(accessToken, 'me');
					}
				}
			} catch (Exception e) {
				error = e.getMessage();
			}
			
			return me;
		} set;
	}

	/* END Code copied from FacebookSampleController */

	private PDIContactsManager cm = new PDIContactsManager();
	

    /*
     * Get Contact from database
     * Create JSON document using the Contact data
     * Send Contact via AJAX request and redirects to the URL told by the back-office
     */
	public PageReference basicAuthCallout() {
	  	FacebookUser fb = this.me;
	  	Contact c = cm.retrieveContact(fb.id);
			
        String json = this.createJSON(c);
        String url  = this.sendContactJSON(json);

        return new PageReference(url);
    }


	public String sendContactJSON(String json) {
		HttpRequest req = new HttpRequest();
  		req.setHeader('content-type', 'text/json');
        req.setEndpoint('http://backoffice-process-manager.herokuapp.com/payment/acquire/service');
        req.setMethod('POST');
		req.setBody(json);

        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        return res.getBody();
	}


    public String createJSON(Contact c) {
    	String none = '0';
    	String filteredCity = this.filterSpecialChars( c.MailingCity );
        String countryCode  = this.translateToCode( c.MailingCountry );
        
        JSONGenerator gen = JSON.createGenerator(true);
       	gen.writeStartObject();
       	gen.writeStringField('tef_account', c.Id);
       	gen.writeStringField('first_name', c.FirstName);
       	gen.writeStringField('last_name', c.LastName);
       	gen.writeStringField('gender', c.Gender__c);
		gen.writeStringField('city', filteredCity);
		gen.writeStringField('country', countryCode);
		gen.writeStringField('email', c.Email);
		
		gen.writeStringField('address', none);
		gen.writeStringField('postal_code', none);
		gen.writeStringField('phone', none);
		gen.writeEndObject();
		
		return gen.getAsString();
    }


	private String filterSpecialChars(String city) {
		city = city.replace('ã', 'a');
		city = city.replace('ñ', 'n');
		return city; 		
	}


    private String translateToCode(String country) {
    	String code = 'none';

		if ( 'Brazil'.equalsIgnoreCase( country ) ) {
			code = 'BR';
			
		} else if ( 'Spain'.equalsIgnoreCase( country ) ) {
			code = 'ES';
		}
		
    	return code;
    }

}