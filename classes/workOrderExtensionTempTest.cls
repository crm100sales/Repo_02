public class workOrderExtensionTempTest {

    
    public  Work_Order__c wkord {get;set;} 
    public  Job_Cost__c jbpost {get;set;}
          
      
    public workOrderExtensionTempTest(ApexPages.StandardController stdController) {
      this.wkord = (Work_Order__c)stdController.getRecord();
     // system.debug('Workorder' +  this.jbpost);
      List<id> wkorderid = new List<id>();
      List<Work_Order__c> wkorderlst = new List<Work_Order__c>();
      wkorderid.add(wkord.id);
      
    wkorderlst = [Select id, name,Work_Order_Date__c,Issued_To__c,Vendor_ID__c, Vendor_Quote__c,ABIS_Authorized_By__r.name,Ship_To__r.name,  
                  Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet,
                  Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                  Ship_To__c, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c, Additional_Comments__c
                  From Work_Order__c where id in: wkorderid limit 1];
    this.wkord = wkorderlst[0];
    }
    
}