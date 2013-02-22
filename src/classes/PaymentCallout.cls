public with sharing class PaymentCallout {
  public void basicAuthCallout(){
    HttpRequest req = new HttpRequest();
    req.setEndpoint('http://payment-enabler.herokuapp.com/payment_menu');
    req.setMethod('POST');
    
    String json = '{payment_value : , tef_account : ,city : , address : , postal_code : , country : , phone : , email : }';
    
    req.setBody(json);
    
    // Create a new http object to send the request object
    // A response object is generated as a result of the request  
 
    Http http = new Http();
    HTTPResponse res = http.send(req);
    System.debug(res.getBody());
  }
}