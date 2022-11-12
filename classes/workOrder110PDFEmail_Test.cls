@isTest
private class workOrder110PDFEmail_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
        Work_Order__c work_order_Obj = new Work_Order__c();
        Insert work_order_Obj; 
    test.stopTest();
  }
  static testMethod void test_sendPDFOutboundEmail_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
      
    PageReference pageRef = Page.WorkOrder110PDF_Email;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
      
    Test.setCurrentPage(pageRef);
    workOrder110PDFEmail obj01 = new workOrder110PDFEmail();
    //obj01.workOrderRecId = '01p90000006uk2w';
     obj01.email1 = 'Test@gmail.com';
     obj01.email2 = 'Test@gmail.com';
     obj01.email3 = 'Test@gmail.com';
     obj01.email4 = 'Test@gmail.com';
     obj01.email5 = 'Test@gmail.com';
    //obj01.workOrderRec = new Work_Order__c();
    //obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.sendPDFOutboundEmail();
  }
}