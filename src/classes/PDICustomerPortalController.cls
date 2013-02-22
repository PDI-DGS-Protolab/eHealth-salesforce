public class PDICustomerPortalController extends FacebookLoginController {
        /* BEGIN Code copied from FacebookSampleController */
        
        private static String authProviderId = null;

    public String message {get; set;}
    public String postId {get; set;}
    public String userData {get; set;} 
    public String error {get; set;}
    

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
    
    ApexPages.standardController m_sc = null;
    
    private PDIContactsManager cm;
    private FacebookUser fb;
    private Contact c;
    
    public PDICustomerPortalController(ApexPages.StandardController controller) {
                
        m_sc = controller;
        
        userData = 'null';
        this.cm = new PDIContactsManager();
        this.fb = this.me;
        this.c  = this.cm.retrieveContact(this.fb.id);
    }
    
    
    public Contact contact {
        get {
                return this.c;
        }
    }
        
    public PageReference save() {
        update c;    
        return null;
    }
    
}