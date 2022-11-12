public with sharing class workOrder100 {
    
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
    
    public  List<Vendor_Sub_Costs__c> Vndrlst  = new List<Vendor_Sub_Costs__c>();
    public  List<Job_Cost__c> Jblst  = new List<Job_Cost__c>();
    public  List<Work_Order__c> wkorderlst = new List<Work_Order__c>();    
    public  Boolean taxedCheckbox {get;set;}     
    
    
    public workOrder100() {        
        this.jobCostId =  ApexPages.currentPage().getParameters().get('id');
        system.debug('Value for this.jobCostId is: ' +  this.jobCostId);
        wrapVndrList = new List<wrapVndr>();
        
        this.Todaydate = System.today(); 
        this.workOrderVF = new Work_Order__c();
    }
    
    public void onloadmethod(){
        
        // #1 -> Read fields for Job Cost record with Job Cost record id
        this.Jblst = [Select id, name,createdDate,Opportunity__r.Account.Vendor__c, Opportunity__r.AccountId, Opportunity__r.Account.BillingStreet,
                Opportunity__r.Account.BillingCity, Opportunity__r.Account.BillingState, Opportunity__r.Account.BillingPostalCode, Opportunity__r.Account.BillingCountry,
                Opportunity__r.Account.Phone, Account_Name__c, Difference_Vendor_and_Sub_Costs__c, G_A_Departmental__c,Labor_Burden__c,
                Opportunity__c,Quote_Id__c,Subtotal_Direct_Labor_Cost__c,
                Tools_and_training__c,Total_Direct_Costs_Or_Materials__c,
                Total_Direct_Labor_Cost__c,Total_Forecast_Revenue__c,
              //Total_Project_Cost_Forecast__c,Total_Vendor_and_Sub_Costs__c from Job_Cost__c where id in: jobid ];
                Total_Project_Cost_Forecast__c,Total_Vendor_and_Sub_Costs__c from Job_Cost__c where id =: this.jobCostId ];
                
        this.finaljbpost =  Jblst[0];         
        
        // #2 -> Read fields for Job Cost -> Vendor & Sub Costs with Job Cost record id
        this.Vndrlst = [Select Actual_Amount__c,Budgeted_Amount__c,Budgeted_Extended__c,
                        Comments__c,Count__c,Description__c,Difference__c,
                        Job_Cost__c,Line_Item__c,Unit_of_Measure__c
                     // From Vendor_Sub_Costs__c where Job_Cost__c in: jobid ORDER BY Line_Item__c ASC];
                        From Vendor_Sub_Costs__c where Job_Cost__c =: this.jobCostId  ORDER BY Line_Item__c ASC];
                        
            for(Vendor_Sub_Costs__c vnlst : Vndrlst){
                   wrapVndrList.add(new wrapVndr(vnlst));
            }  
    }
    
    //#3 -> Method to populate Vendorlist from #2
    public List<Vendor_Sub_Costs__c> getvenderlst(){
        return Vndrlst;
    }
    
    //#4 -> Method to remove/delete a Line Item from Vendorlist from #3
    public void removeContact(){
        Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));        
        system.debug('CheckVendar' + indexVal);                  
        wrapVndrList.remove(indexVal-1);      
    } 
    
    public ID accountId {get;set;}
    public String email {get;set;}
    public ID workOrderId {get;set;}
    public ID currentPageworkOrderId {get;set;}
       
    public PageReference CreateWorkorddetails(){        
        
        List<Work_Order_Line_Item__c> workitemlist = new List<Work_Order_Line_Item__c>();
        Map<id,String>  mapobj = new Map<id, String>();
       
        List<String> wkordnames = new List<string>();        
       
            //Create a new Work Order record with the values selected from VF page
            List<Contact> ContactSelected = [Select id, name from Contact where id =: workOrderVF.Id];        
            
           // Work_Order__c wrkOrdRecordForVF = new Work_Order__c();
            
           // workOrderVF.Work_Order_Date__c = TodaydateVF;  
            //workOrderVF.Work_Order_Date__c = system.today();
            
            //Work Order # field is Auto generated
            //Work Order Date field is set by the VF page           
            workOrderVF.Issued_To__c = finaljbpost.Opportunity__r.AccountId;
            workOrderVF.Vendor_ID__c = finaljbpost.Opportunity__r.Account.Vendor__c;
            workOrderVF.Vendor_Quote__c = VnderquoteVF;
            //Work Order ABIS Authorized By field is set by the VF page
            workOrderVF.ABIS_Project__c = finaljbpost.Quote_ID__c;  
        
            //Work Order Work Description field is set by the VF page 
            workOrderVF.Bill_To__c =  finaljbpost.Opportunity__r.AccountId;
            workOrderVF.Ship_To1__c = finaljbpost.Opportunity__c; 
            workOrderVF.Job_Cost__c = jobCostId;
            //Work Order Ship To Project Location is set by the VF page
            //Work Order Ship To Street Address is set by the VF page
            //Work Order Ship To City, State, ZipCode is set by the VF page         
            system.debug('Value for workOrderVF' +workOrderVF );
        
            insert workOrderVF; 
            system.debug('Value for workOrderVF Id created' +workOrderVF.id );   
                
      //if(Vndrlst.size()>0){ 
      if(wrapVndrList.size()>0){     
        List<Vendor_Sub_Costs__c> vlst = new List<Vendor_Sub_Costs__c>();        
        List<id> vndrlstids = new List<id>();
            
           //Get all the Vendor Line Items for this Job Cost record id and store them in 'vndrlstids' List
           vlst = [Select Actual_Amount__c,Budgeted_Amount__c,Budgeted_Extended__c,
                        Comments__c,Count__c,Description__c,Difference__c,
                        Job_Cost__c,Line_Item__c,Unit_of_Measure__c
                      //From Vendor_Sub_Costs__c where Job_Cost__c in: jobid]; 
                        From Vendor_Sub_Costs__c where Job_Cost__c =: this.jobCostId];                                     
            
            for(Vendor_Sub_Costs__c vdlst :vlst){
               //s mapobj.put(vdlst.id,vdlst.id + vdlst.Count__c);
                vndrlstids.add(vdlst.id);
            }          
            system.debug('Checkvndrlstidss' +  vndrlstids.size()); 
            //system.debug('Checkvndrlst' +  Vndrlst.size());
            system.debug('Checkvndrlst' +  wrapVndrList.size());
          
            //Run for loop on 'vndrlstids' List and then create individual 'Work Order Line Item' records
            // as a child for newly created 'Work Order' record
            //for(Vendor_Sub_Costs__c vndrlstt : Vndrlst){
            
            for(wrapVndr vndrlstt : wrapVndrList){  
                Work_Order_Line_Item__c wrkitem = new Work_Order_Line_Item__c();
                        
                wrkitem.Line_Item__c =   vndrlstt.vndrrec.Line_Item__c;
                wrkitem.Description__c = vndrlstt.vndrrec.Description__c;
                wrkitem.Quantity__c =    vndrlstt.vndrrec.Count__c;      
                wrkitem.Unit_Price__c =  vndrlstt.vndrrec.Budgeted_Amount__c;
                wrkitem.Taxed__c =       vndrlstt.selected;                     
                wrkitem.Work_Order__c = workOrderVF.id;
                    
                workitemlist.add(wrkitem);                 
            }          
        }        
            insert   workitemlist;
            system.debug('finalworkitemlist' + workitemlist);                    
        
        //After this new Work Order record is saved -> Return the pagereference to View this record
        return New_VFPage();
    } 
    
    // To redirect to next VF page after Save
    public PageReference New_VFPage(){            
          Pagereference ref1 = new Pagereference('/apex/WorkOrder110?id=' +workOrderVF.id); 
          ref1.setRedirect(true);
          return ref1;          
    }
    
     public PageReference Canceloperation(){ 
          Pagereference ref1 = new Pagereference('/' +jobCostId);           
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