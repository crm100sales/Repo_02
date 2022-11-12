public with sharing class workOrderExtension130 {
    
    public id workOrderRecId {get;set;}
    public Work_Order__c workOrderRec {get;set;}
    public List<Work_Order__c> workOrderRecList = new List<Work_Order__c>();    
    public List<Work_Order_Line_Item__c> workOrderLineItemList {get;set;}
    
    public  id jobCostId {get;set;}
    public List<wrapVndr> wrapVndrList {get; set;}

    //public  Work_Order__c wrkOrdRecordForVF {get;set;} //New code
    public Date TodaydateVF{get;set;}
    public String VnderquoteVF {get;set;}
    public Work_Order__c workOrderVF {get;set;}
    
    public  Work_Order__c wkord {get;set;} 
    public  Work_Order__c wrkordrec = new Work_Order__c();
    
    public Date Todaydate{get;set;}
    public String Vnderquote{get;set;}
    
    public  Job_Cost__c jbpost {get;set;}
    public  Job_Cost__c finaljbpost {get;set;}
    
    public  List<Direct_Costs_Or_Materials__c> Vndrlst  = new List<Direct_Costs_Or_Materials__c>();
    public  List<Job_Cost__c> Jblst  = new List<Job_Cost__c>();
    public  List<Work_Order__c> wkorderlst = new List<Work_Order__c>();    
    public  Boolean taxedCheckbox {get;set;} 
    
    public workOrderExtension130() {
        this.workOrderRecId =  ApexPages.currentPage().getParameters().get('id');
        system.debug('Value for this.workOrderRecId is: ' +  this.workOrderRecId);
        
        this.jobCostId =  'a0t1R00000Dz3i3';
        system.debug('Value for this.jobCostId is: ' +  this.jobCostId);
        wrapVndrList = new List<wrapVndr>();
        //this.jbpost = (Job_Cost__c)stdController.getRecord();
        //this.jbpost = new Job_Cost__c();
        this.Todaydate = System.today(); 
        this.workOrderVF = new Work_Order__c();
    }
    
    public void onloadmethod(){
        //taxedCheckbox = false;
        //system.debug('Workorder' +  this.jbpost);
        //List<id> jobid = new List<id>();
        
        //jobid.add(jbpost.id);
        
        // #1 -> Read fields for Job Cost record with Job Cost record id
        this.Jblst = [Select id, name,createdDate,Opportunity__r.Account.Vendor_ID__c, Opportunity__r.AccountId, Opportunity__r.Account.BillingStreet,
                Opportunity__r.Account.BillingCity, Opportunity__r.Account.BillingState, Opportunity__r.Account.BillingPostalCode, Opportunity__r.Account.BillingCountry,
                Opportunity__r.Account.Phone, Account_Name__c, Difference_Vendor_and_Sub_Costs__c, G_A_Departmental__c,Labor_Burden__c,
                Opportunity__c,Quote_Id__c,Subtotal_Direct_Labor_Cost__c,
                Tools_and_training__c,Total_Direct_Costs_Or_Materials__c,
                Total_Direct_Labor_Cost__c,Total_Forecast_Revenue__c,
              //Total_Project_Cost_Forecast__c,Total_Vendor_and_Sub_Costs__c from Job_Cost__c where id in: jobid ];
                Total_Project_Cost_Forecast__c,Total_Vendor_and_Sub_Costs__c from Job_Cost__c where id =: this.jobCostId ];
                
        this.finaljbpost =  Jblst[0];  
       // this.finaljbpost.createdDate = system.today();             
        
        // #2 -> Read fields for Job Cost -> Vendor & Sub Costs with Job Cost record id
        this.Vndrlst = [SELECT Actual_Amount__c,Budgeted_Amount__c,Budgeted_Extended__c,Comments__c,Count__c,
                        CreatedById,CreatedDate,Description__c,Difference__c,Id,IsDeleted,Job_Cost__c,LastActivityDate,
                        LastModifiedById,LastModifiedDate,Line_Item__c,Name,SystemModstamp,Unit_of_Measure__c 
                        FROM Direct_Costs_Or_Materials__c where Job_Cost__c =: this.jobCostId  ];
                        
            for(Direct_Costs_Or_Materials__c vnlst : Vndrlst){
                   wrapVndrList.add(new wrapVndr(vnlst));
            }            
        
        wkorderlst = [Select id, name,Work_Order_Date__c,Issued_To__c,Vendor_ID__c,Vendor_Quote__c,ABIS_Authorized_By__c,ABIS_Authorized_By__r.name,Ship_To__r.name, Job_Cost__c,  
                      Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet,
                      Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                      Ship_To__c, Ship_To1__c, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c, Additional_Comments__c
                      //From Work_Order__c where Job_Cost__c in: jobid ];
                      From Work_Order__c where Job_Cost__c =: this.jobCostId ];     
                      
        system.debug('Entered CreateWorkorddetails Construtor' + wkorderlst);              
        this.wkord = wkorderlst[0];
        system.debug('Value for this.wkord' +this.wkord );
        
        //New code by Pankaj
        //Query fields for Work Order based on Work Order id from url
        workOrderRecList = [Select id, Name, Issued_To__c, Job_Cost__c, Vendor_ID__c,Vendor_Quote__c,ABIS_Authorized_By__c,ABIS_Authorized_By__r.name,Ship_To__r.name, 
                      Work_Description__c, Work_Order_Date__c, Additional_Comments__c, Other__c, Shipping_Handling__c, Sub_Total__c,Total__c, 
                      Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet,
                      Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                      Ship_To__c, Ship_To1__c, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c                     
                      From Work_Order__c where id =: this.workOrderRecId ];
        
        this.workOrderRec = workOrderRecList[0];
        
        //Query fields for Work Order List Items based on Work Order id (parent)
        workOrderLineItemList = [Select id, Name, Description__c, Line_Item__c, Line_Total__c, Quantity__c, Taxable__c, Taxed__c, Unit_Price__c, Work_Order__c 
                                From Work_Order_Line_Item__c where Work_Order__c =: this.workOrderRec.Id ];
        
    }
    
    //#3 -> Method to populate Vendorlist from #2
    public List<Direct_Costs_Or_Materials__c> getvenderlst(){
        return Vndrlst;
    }
    
    //#4 -> Method to remove/delete a Line Item from Vendorlist from #3
    public void removeContact(){
        Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        //If the vendar is an existing contact then add it to the list to delete from the databse
        system.debug('CheckVendar' + indexVal);
      //  if(Vndrlst[indexVal - 1].Id != null)
            //Vndrlst.add(Vndrlst[indexVal - 1]);
        //Remove the vendar from the table    
        //Vndrlst.remove(indexVal-1);            
        wrapVndrList.remove(indexVal-1);      
    } 
    
    public ID accountId {get;set;}
    public String email {get;set;}
    public ID workOrderId {get;set;}
    public ID currentPageworkOrderId {get;set;}
    
    public List<SelectOption> workOrders {
        get {
            if (workOrders == null) {
                workOrders = new List<SelectOption>();
                workOrders.add(new SelectOption('a0y1R00000HPEnM','WO-000002'));
                //workOrders.add(new SelectOption('0017000000LgRMV','Burlington Textiles Corp of America'));
            }
            return workOrders;
        }
        set;
    }
    
    public Void CreateWorkorddetails(){
           
           Update workOrderRec;
           Update workOrderLineItemList;
        
    } 
    
    // To redirect to next VF page after Save
    public PageReference New_VFPage(){            
          Pagereference ref1 = new Pagereference('/' +workOrderVF.id);                  
          ref1.setRedirect(true);
          return ref1;          
    }
    
    public PageReference printPdfWorkOrder(){
        
        system.debug('Entered printPdfWorkOrder method: ' );        
        
/*        PageReference pdf1 = Page.PdfGeneratorTemplateWorkOrder;
        // add parent id to the parameters for standardcontroller
        pdf1.getParameters().put('Id', workOrderId);
        pdf1.setRedirect(true);
            
        return pdf1;    
 */       
       // PageReference currentVFPage = ApexPages.currentPage();
       // currentPageworkOrderId = currentVFPage.getParameters().get('id');
       
        id workOrderRecId =  ApexPages.currentPage().getParameters().get('id');        
        Pagereference ref1 = new Pagereference('/apex/WorkOrder110PDF?id=' +workOrderRecId);                  
        ref1.setRedirect(true);
        return ref1;   
    }
    
    
     public class wrapVndr {
        public Direct_Costs_Or_Materials__c vndrrec {get; set;}
        public Boolean selected {get; set;}
 
        public wrapVndr(Direct_Costs_Or_Materials__c a) {
            vndrrec = a;
            selected = false;
        }
    }
}