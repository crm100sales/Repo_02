public with sharing class workOrder110 {
    
    public id workOrderRecId {get;set;}
    public Work_Order__c workOrderRec {get;set;}
    public List<Work_Order__c> workOrderRecList = new List<Work_Order__c>();    
    public List<Work_Order_Line_Item__c> workOrderLineItemList {get;set;}

    //public  Work_Order__c wrkOrdRecordForVF {get;set;} //New code
    public Date TodaydateVF{get;set;}
    public String VnderquoteVF {get;set;}
    public Work_Order__c workOrderVF {get;set;}
    
    public  Work_Order__c wkord {get;set;} 
    public  Work_Order__c wrkordrec = new Work_Order__c();
    
    public Date Todaydate{get;set;}
    public String Vnderquote{get;set;}
    
    public  Job_Cost__c jbpost {get;set;}
	//public List<Work_Order__c> parentJobCostRecord {get;set;}
    //public Id parentJobCostRecordId {get;set;}
    
    public  List<Vendor_Sub_Costs__c> Vndrlst  = new List<Vendor_Sub_Costs__c>();
    public  List<Job_Cost__c> Jblst  = new List<Job_Cost__c>();
    //public  List<Work_Order__c> wkorderlst = new List<Work_Order__c>();    
    public  Boolean taxedCheckbox {get;set;} 
    
    public String email {get;set;}     
    
    public workOrder110(ApexPages.StandardController stdController) { 
    	this.workOrderRecId =  ApexPages.currentPage().getParameters().get('id');
        system.debug('Value for this.workOrderRecId is: ' +  this.workOrderRecId);
        
        this.Todaydate = System.today(); 
        this.workOrderVF = new Work_Order__c();        
    }
    
    public workOrder110() {
        this.workOrderRecId =  ApexPages.currentPage().getParameters().get('id');
        system.debug('Value for this.workOrderRecId is: ' +  this.workOrderRecId);
       
        // wrapVndrList = new List<wrapVndr>(); 
        //this.jbpost = (Job_Cost__c)stdController.getRecord();
        //this.jbpost = new Job_Cost__c();
        this.Todaydate = System.today(); 
        this.workOrderVF = new Work_Order__c();
    }
    
    public void onloadmethod(){        
        //Query fields for Work Order based on Work Order id from url
        workOrderRecList = [Select id, Name, Issued_To__c,Issued_To__r.Name, Job_Cost__c, Vendor_ID__c,Vendor_Quote__c,ABIS_Authorized_By__c,ABIS_Authorized_By__r.name,Ship_To__r.name, 
                      Work_Description__c, Work_Description1__c, Work_Order_Date__c, Additional_Comments__c, Other__c, Shipping_Handling__c, Sub_Total__c, Taxable__c, Tax_Rate__c, Tax__c, Total__c, 
                      Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet, ABIS_Project__c,
                      Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                      Ship_To__c, Ship_To1__c, Ship_To1__r.Name, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c                     
                      From Work_Order__c where id =: this.workOrderRecId ];
        
        this.workOrderRec = workOrderRecList[0];
        
        //Query fields for Work Order List Items based on Work Order id (parent)
        workOrderLineItemList = [Select id, Name, Description__c, Line_Item__c, Line_Total__c, Quantity__c, Taxable__c, Taxed__c, Unit_Price__c, Work_Order__c 
                                From Work_Order_Line_Item__c where Work_Order__c =: this.workOrderRec.Id ];
        
    }
    
    //#3 -> Method to populate Vendorlist from #2
    public List<Vendor_Sub_Costs__c> getvenderlst(){
        return Vndrlst;
    }
    
    //#4 -> Method to remove/delete a Line Item from Vendorlist from #3
    public void removeContact(){
        Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        //If the vendar is an existing contact then add it to the list to delete from the database
        system.debug('CheckVendar' + indexVal);
        
       /*      if(Vndrlst[indexVal - 1].Id != null)
        //Vndrlst.add(Vndrlst[indexVal - 1]);
        //Remove the vendar from the table    
        //Vndrlst.remove(indexVal-1);            
       // wrapVndrList.remove(indexVal-1);      
*/ 
    
    } 
    
    public ID accountId {get;set;}    
    public ID workOrderId {get;set;}
    public ID currentPageworkOrderId {get;set;}
       
    public PageReference saveWorkOrderDetails(){           
        Update workOrderRec;
        Update workOrderLineItemList;
        
        Pagereference ref1 = new Pagereference('/apex/WorkOrder110?id=' +workOrderRecId);                  
        ref1.setRedirect(true);
        return ref1;
    } 
    
    // To redirect to next VF page after Save
    public PageReference New_VFPage(){            
          Pagereference ref1 = new Pagereference('/' +workOrderVF.id);                  
          ref1.setRedirect(true);
          return ref1;          
    }
    
    public PageReference printPdfVFPage(){        
        system.debug('Entered printPdfWorkOrder method: ');  

        id workOrderRecId =  ApexPages.currentPage().getParameters().get('id');        
        Pagereference ref1 = new Pagereference('/apex/WorkOrder110PDF?id=' +workOrderRecId);                  
        ref1.setRedirect(true);
        return ref1;   
    }
    
    public PageReference emailPdfVFPage(){        
        system.debug('Entered emailPdfWorkOrder method: '); 

        id workOrderRecId =  ApexPages.currentPage().getParameters().get('id');        
        Pagereference ref1 = new Pagereference('/apex/WorkOrder110PDF_Email?id=' +workOrderRecId);                  
        ref1.setRedirect(true);
        return ref1;   
    }
    
    public PageReference returnToJobCost(){        
        system.debug('Entered returnToJobCost method: '); 
		
        List<Work_Order__c> parentJobCostRecord = [Select id, Job_Cost__c from Work_Order__c where id =: workOrderRecId Limit 1];        
        
        Id parentJobCostRecordId = parentJobCostRecord[0].Job_Cost__c;
        
        Pagereference ref1 = new Pagereference('/' +parentJobCostRecordId);                  
        ref1.setRedirect(true);
        return ref1;
    }
    
    public class wrapVndr {
        public Vendor_Sub_Costs__c vndrrec {get; set;}
        public Boolean selected {get; set;}
 
        public wrapVndr(Vendor_Sub_Costs__c a) {
            vndrrec = a;
            selected = false;
        }
    }
}