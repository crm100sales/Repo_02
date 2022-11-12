@isTest
private class workOrder100_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    
    List<Account> aList = new List<Account> {
       new Account (Name = 'My Test Account',Vendor__c='test')
   };
  insert aList;
  List<Opportunity> oList = new List<Opportunity> {
     new Opportunity(	Name ='00New mAWS Deal',
                        AccountID =aList[0].id,
                        Business_Practice__c = 'FS - Field Services',
                   		Business_Unit__c = 'ACO',
                        StageName = 'S6 - Verbal Award',
                     	ForecastCategoryName = 'Pipeline',                        
                        CloseDate = System.today(),
                     	Type = 'New Business',
                     	Amount = 3000
                        ),         
         
   new Opportunity( 	  Name = '01mAWS Usage', 
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
    test.stopTest();
  }
  static testMethod void test_onloadmethod_UseCase1(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.WorkOrder100;
    pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
    obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
    obj01.workOrderId = '01p90000006uk2w';
    obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
    obj01.onloadmethod();
  }
  static testMethod void test_getvenderlst_UseCase1(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.WorkOrder100;
     pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
    obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
    obj01.workOrderId = '01p90000006uk2w';
    obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
    obj01.getvenderlst();
  }
  static testMethod void test_removeContact_UseCase1(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.WorkOrder100;
     pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','1');
    Test.setCurrentPage(pageRef);
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
    //obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
  //bj01.workOrderId = '01p90000006uk2w';
   //bj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
   // obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Vndrlst = [Select id from Vendor_Sub_Costs__c];
   /*  for(Vendor_Sub_Costs__c vnlst : obj01.Vndrlst){
                  obj01.wrapVndrList.add(new wrapVndr(vnlst));
            }*/ 
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
   // obj01.removeContact();
  }
    
  static testMethod void test_CreateWorkorddetails_UseCase1(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id,Opportunity__r.AccountId,Opportunity__r.Account.Vendor__c,Quote_ID__c from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
      
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [Select Actual_Amount__c,Budgeted_Amount__c,Budgeted_Extended__c,Comments__c,Count__c,Description__c,
                        								Difference__c, Job_Cost__c,Line_Item__c,Unit_of_Measure__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
      
    workOrder100.wrapVndr wrapperTestRecord = new workOrder100.wrapVndr(vendor_sub_costs_Obj[0]);
        
      
    PageReference pageRef = Page.WorkOrder100;
    pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','0');
      
    Test.setCurrentPage(pageRef);
      
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
      
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.wrapVndrList.add(wrapperTestRecord);
      
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
    //obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
    obj01.CreateWorkorddetails();
      
  }
    
  static testMethod void test_New_VFPage_UseCase1(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.WorkOrder100;
      pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
  //  obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
   // obj01.workOrderId = '01p90000006uk2w';
   // obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
    obj01.New_VFPage();
  }
  static testMethod void test_Canceloperation_UseCase1(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.WorkOrder100;
     pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
   // obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
  //  obj01.workOrderId = '01p90000006uk2w';
   // obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
    obj01.Canceloperation();
  }
   static testMethod void test_workOrder100wrapVndr(){
    List<Job_Cost__c> job_cost_Obj  =  [SELECT id from Job_Cost__c];
    System.assertEquals(true,job_cost_Obj.size()>0);
    List<Vendor_Sub_Costs__c> vendor_sub_costs_Obj  =  [SELECT Job_Cost__c from Vendor_Sub_Costs__c];
    System.assertEquals(true,vendor_sub_costs_Obj.size()>0);
    PageReference pageRef = Page.WorkOrder100;
    pageRef.getParameters().put('id',job_cost_Obj[0].id);
    pageRef.getParameters().put('index','0');
    Test.setCurrentPage(pageRef);
    workOrder100 obj01 = new workOrder100();
    obj01.jobCostId = vendor_sub_costs_Obj[0].Job_Cost__c;
    obj01.wrapVndrList = new List<workOrder100.wrapVndr>();
    obj01.TodaydateVF = Date.today();
    obj01.VnderquoteVF = 'test data';
    obj01.workOrderVF = new Work_Order__c();
    obj01.wkord = new Work_Order__c();
    obj01.Todaydate = Date.today();
    obj01.Vnderquote = 'test data';
    obj01.jbpost = job_cost_Obj[0];
    obj01.finaljbpost = job_cost_Obj[0];
    obj01.taxedCheckbox = false;
    //obj01.accountId = '01p90000006uk2w';
    obj01.email = 'test data';
    //obj01.workOrderId = '01p90000006uk2w';
    //obj01.currentPageworkOrderId = '01p90000006uk2w';
    obj01.wrkordrec = new Work_Order__c();
    obj01.Vndrlst = new List<Vendor_Sub_Costs__c>();
    obj01.Jblst = new List<Job_Cost__c>();
    obj01.wkorderlst = new List<Work_Order__c>();
    workOrder100.wrapVndr obj261 = new workOrder100.wrapVndr(new Vendor_Sub_Costs__c());
    obj261.vndrrec = vendor_sub_costs_Obj[0];
    obj261.selected = false;
  }
}