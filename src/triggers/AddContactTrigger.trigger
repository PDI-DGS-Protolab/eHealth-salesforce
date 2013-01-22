trigger AddContactTrigger on FacebookSession__c (after insert) {
       
    for (FacebookSession__c fsc : Trigger.new) {
    	PDIFacebookCallout.getUserInfo(fsc.AccessToken__c);
    }
    
}