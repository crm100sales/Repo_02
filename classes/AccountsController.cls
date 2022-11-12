public class AccountsController {
 
/*  @AuraEnabled
  public static List<Accounts__x> getAccounts() {
    return [Select DisplayUrl, ExternalId, Name__c from Accounts__x ];
      
    //return new DMLResponseAura  ('Success', 'This is to test Success message');
    //return new DMLResponseAura  ('Success', 'This is to test Success message', True);
  }*/
    
    
   @AuraEnabled
  public static DMLResponseAura getAccounts() {
   // return [Select DisplayUrl, ExternalId, Name__c from Accounts__x ];
      
    return new DMLResponseAura  ('Success', 'This is to test Success message');
    //return new DMLResponseAura  ('Success', 'This is to test Success message', True);
  }   
}