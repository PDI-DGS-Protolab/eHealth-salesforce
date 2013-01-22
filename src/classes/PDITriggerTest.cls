public with sharing class PDITriggerTest {

	public static void main() {
		FacebookSession__c fbsc = new FacebookSession__c();
		fbsc.OwnerId        = '005d0000001LDLXAA4'; 
		fbsc.AccessToken__c = 'XUNqcgH95hy5e37TWRL+lWBC7YAKKLAXHd6c3oKlv8Yz16VGjmurUdFEwg+C15vbetrG5TiZ3QmwtfyL5yjkPrZYjXSxYDtO3xeNPUbdfCd5DEmyXkhQINl+aaWnItXW4H4wy6l4u5rNh4VsHA2J/XRQWv5TlcN00cqR11uuu29YUvG+QBQ8fyAh8dcogBtC';
		fbsc.Expiry__c = Date.today();
		fbsc.SessionId__c = '-2.864.571.719.420.167.355-8.395.888.027.050.346.834';
		insert fbsc;
	}
	
}


/*public class TriggerTests {
 static testMethod void testContactmembershipInfoTrigger() {
  Account account = new Account(name = 'wowowowowowosl');
  insert account;
  Contact contact = new Contact(LastName = 'XxXxXxX', Account = account, Email = 'xxxxx@xxxxx.org');
  insert contact;
  Product2 product = [select Id, name from Product2 where name = 'Membership']; 
  
  Membership__c membership = new Membership__c(Account__c = account.Id, Contact__c = contact.Id, Product__c = product.Id, Start_Date__c = Date.today(), Expiration_Date__c = Date.today(), Cost__c = 599);
  insert membership;
  account = null;
  contact = null;
  product = null;
  
  Contact newContact = [SELECT Id, Membership_Expiration__c, Membership_Type__c FROM Contact WHERE LastName = 'XxXxXxX'];
  
  if (newContact != null) {
   Membership__c mbr = [SELECT Id, Contact__c FROM Membership__C WHERE Contact__r.LastName = 'XxXxXxX']; 
   System.assertNotEquals(null, mbr, 'mbr object is null');
   
   newContact.LastName = 'YyYyYyYy';
   update newContact;
   
   delete newContact;
  }
  delete membership;
 }
}*/