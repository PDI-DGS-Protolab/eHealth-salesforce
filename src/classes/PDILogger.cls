public class PDILogger {

	public PDILogger() {}

	public static void log(String slog) {
		
		/*
		Account a = null;
		
		try {
			a = [SELECT Id FROM Account WHERE name = 'logger'];
			
		} catch (QueryException e) {
			a = new Account();
			a.Name = Math.random().format();
			insert a;
			
		} finally {
			insert new Contact(
	        	AccountId = '001d000000Xp1P0AAJ',
	        	FirstName = 'logger',
	        	LastName  = 'logger',
	        	Description = slog,
	        	FacebookId__c = 'fbid'
        	);
		}
		*/
			insert new Contact(
	        	AccountId = '001d000000Xp1P0AAJ',
	        	FirstName = 'logger',
	        	LastName  = 'logger',
	        	Description = slog,
	        	FacebookId__c = 'fbid'
        	);

	    
	}

	/*
    public static void log_old(String slog) {
    	Account acc = [SELECT Id FROM Account WHERE name = 'Facebook'];
        
		try {
			Contact old = [SELECT Id FROM Contact WHERE FirstName = 'log'];
			delete old;
			
		} catch (Queryexception e) {
			// We don't do anything
						
		} finally {
			
			insert new Contact(
	        	AccountId = acc.id,
	        	FirstName = 'log',
	        	LastName  = 'log',
	        	Description = slog,
	        	FacebookId__c = 'user.id',
	        	TefAccount__c = 'none'
	        );	
		}
		
    }
	*/
	
}