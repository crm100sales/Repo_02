@isTest
private class workOrder110_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
      
      List<Account> aList = new List<Account> {
      new Account (Name = 'My Test Account',Vendor__c='test') };
      insert aList;
      
      List<Opportunity> oList = new List<Opportunity> {
     new Opportunity(   Name ='00New mAWS Deal',
                        AccountID =aList[0].id,
                        Business_Practice__c = 'FS - Field Services',
                        Business_Unit__c = 'ACO',
                        StageName = 'S6 - Verbal Award',
                        ForecastCategoryName = 'Pipeline',                        
                        CloseDate = System.today(),
                        Type = 'New Business',
                        Amount = 3000
                        ),         
         
       new Opportunity(       Name = '01mAWS Usage', 
                              AccountId = aList[0].id,
                              Business_Practice__c = 'FS - Field Services',
                              Business_Unit__c = 'ACO',
                              StageName = 'S6 - Verbal Award',
                              ForecastCategoryName = 'Pipeline',
                              CloseDate = System.today(),
                              Type = 'New Business',
                              Amount = 555888555)
      };
      insert oList;
        
      Job_Cost__c job_cost_Obj = new Job_Cost__c();
      job_cost_Obj.Opportunity__c = oList[0].id;
      job_cost_Obj.Quote_ID__c = 'test';
      Insert job_cost_Obj; 
      
      Vendor_Sub_Costs__c vendor_sub_costs_Obj = new Vendor_Sub_Costs__c(Job_Cost__c = job_cost_Obj.id);
      Insert vendor_sub_costs_Obj; 
      
      Vendor_Sub_Costs__c vendor_sub_costs_Obj2 = new Vendor_Sub_Costs__c(Job_Cost__c = job_cost_Obj.id);
      Insert vendor_sub_costs_Obj2; 
      
      Vendor_Sub_Costs__c vendor_sub_costs_Obj3 = new Vendor_Sub_Costs__c(Job_Cost__c = job_cost_Obj.id);
      Insert vendor_sub_costs_Obj3; 
      
      
     Work_Order__c work_order_Obj = new Work_Order__c();    
     work_order_Obj.Work_Order_Date__c = Date.today();
     work_order_Obj.Vendor_ID__c = '565544';
     work_order_Obj.Vendor_Quote__c = 'VQ-98744';
     work_order_Obj.Job_Cost__c =  job_cost_Obj.Id;
     Insert work_order_Obj;
      
    test.stopTest();
  }
    
    
  static testMethod void test_onloadmethod_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id, Work_Order_Date__c, Vendor_ID__c, Vendor_Quote__c from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    
    workOrder110 obj01 = new workOrder110();
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
   // obj01.accountId = '01p90000006uk2w';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
   // obj01.onloadmethod();
  // obj01.returnToJobCost();
  }
  static testMethod void test_getvenderlst_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
    //obj01.accountId = '01p90000006uk2w';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.getvenderlst();
  }
  static testMethod void test_removeContact_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT id,Job_Cost__c from Vendor_Sub_Costs__c];
   // System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
   // obj01.accountId = '01p90000006uk2w';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.removeContact();
     // obj01.onloadmethod();
   
  }
  static testMethod void test_saveWorkOrderDetails_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
     pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');   
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
   // obj01.accountId = '01p90000006uk2w';
   // obj01.workOrderId = '01p90000006uk2w';
   // obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.saveWorkOrderDetails();
  }
  static testMethod void test_New_VFPage_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
     pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
   // obj01.accountId = '01p90000006uk2w';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.New_VFPage();
  }
  static testMethod void test_printPdfVFPage_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
     pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
   // obj01.accountId = '01p90000006uk2w';
   // obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.printPdfVFPage();
  }
  static testMethod void test_emailPdfVFPage_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = work_order_Obj[0].id;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
    //obj01.accountId = '01p90000006uk2w';
   // obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.emailPdfVFPage();
    obj01.returnToJobCost();
  }

/*
  static testMethod void test_returnToJobCost_UseCase1(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id, Job_Cost__c from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');   
      
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
    //obj01.accountId = '01p90000006uk2w';
   // obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    
    obj01.parentJobCostRecord = [Select id, Job_Cost__c from Work_Order__c where id =: work_order_Obj[0].id Limit 1]; 
    obj01.parentJobCostRecordId = work_order_Obj[0].Job_Cost__c;
      
    obj01.returnToJobCost();      
  }  
*/
    
   static testMethod void test_workOrder110wrapVndr(){
    List<Work_Order__c> work_order_Obj  =  [SELECT id from Work_Order__c];
    System.assertEquals(true,work_order_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.workOrder110;
    pageRef.getParameters().put('id',work_order_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder110 obj01 = new workOrder110(new ApexPages.StandardController(work_order_Obj[0]));
    obj01.workOrderRecId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.workOrderRec = work_order_Obj[0];
    obj01.workOrderLineItemList = new List<Work_Order_Line_Item__c>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = work_order_Obj[0];
    obj01.wkord = work_order_Obj[0];
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = new Job_Cost__c();
    obj01.taxedCheckbox = false;
    obj01.email = 'test data';
    //obj01.accountId = '01p90000006uk2w';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.workOrderRecList = new List<Work_Order__c>();
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    workOrder110.wrapVndr obj281 = new workOrder110.wrapVndr(new Vendor_Sub_Costs__c());
    obj281.vndrrec = vendor_sub_costs_Obj[0];
    obj281.selected = false;
  }
}