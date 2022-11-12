public  class workOrderExtension2 {
    
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
    
    public workOrderExtension2(ApexPages.StandardController stdController) {
        this.jbpost = (Job_Cost__c)stdController.getRecord();
        this.Todaydate = System.today();
        
    }
    
    public void onloadmethod(){
        //taxedCheckbox = false;
        system.debug('Workorder' +  this.jbpost);
        List<id> jobid = new List<id>();
        
        jobid.add(jbpost.id);
        
        this.Jblst = [Select id, name,createdDate,Opportunity__r.Account.Vendor_ID__c,Account_Name__c, Difference_Vendor_and_Sub_Costs__c, G_A_Departmental__c,Labor_Burden__c,
                Opportunity__c,Quote_Id__c,Subtotal_Direct_Labor_Cost__c,
                Tools_and_training__c,Total_Direct_Costs_Or_Materials__c,
                Total_Direct_Labor_Cost__c,Total_Forecast_Revenue__c,
                Total_Project_Cost_Forecast__c,Total_Vendor_and_Sub_Costs__c from Job_Cost__c where id in: jobid ];
                
        this.finaljbpost =  Jblst[0];  
       // this.finaljbpost.createdDate = system.today();
             
        
        this.Vndrlst = [Select Actual_Amount__c,Budgeted_Amount__c,Budgeted_Extended__c,
                        Comments__c,Count__c,Description__c,Difference__c,
                        Job_Cost__c,Line_Item__c,Unit_of_Measure__c
                        From Vendor_Sub_Costs__c where Job_Cost__c in: jobid ORDER BY Line_Item__c ASC];
        
        wkorderlst = [Select id, name,Work_Order_Date__c,Issued_To__c,Vendor_ID__c,Vendor_Quote__c,ABIS_Authorized_By__c,ABIS_Authorized_By__r.name,Ship_To__r.name, Job_Cost__c,  
                      Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet,
                      Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                      Ship_To__c, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c, Additional_Comments__c
                      From Work_Order__c where Job_Cost__c in: jobid ];
                      
        system.debug('Entered CreateWorkorddetails Construtor' + wkorderlst);              
        this.wkord = wkorderlst[0];
        system.debug('Value for this.wkord' +this.wkord );
    }
    
    public List<Vendor_Sub_Costs__c> getvenderlst(){
        return Vndrlst;
    }
    
    public void removeContact(){
        Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        //If the vendar is an existing contact then add it to the list to delete from the databse
        system.debug('CheckVendar' + indexVal);
      //  if(Vndrlst[indexVal - 1].Id != null)
            //Vndrlst.add(Vndrlst[indexVal - 1]);
        //Remove the vendar from the table    
        Vndrlst.remove(indexVal-1);            
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
    
    public PageReference CreateWorkorddetails(){
        system.debug('Value for taxedCheckbox is: ' +taxedCheckbox);
        
        
    //public void  CreateWorkorddetails(){
        system.debug('Entered CreateWorkorddetails method' + wkorderlst);
        List<Work_Order_Line_Item__c> workitemlist = new List<Work_Order_Line_Item__c>();
        Map<id,String>  mapobj = new Map<id, String>();
        List<id> jobid = new List<id>();
         List<String> wkordnames = new List<string>();        
       jobid.add(jbpost.id);
       wkorderlst = [Select id, name,Work_Order_Date__c,Issued_To__c,Vendor_ID__c,Vendor_Quote__c,ABIS_Authorized_By__r.name,Ship_To__r.name, Job_Cost__c,  
                      Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet,
                      Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                      Ship_To__c, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c, Additional_Comments__c
                      From Work_Order__c where Job_Cost__c in: jobid ];
                      
         for(Work_Order__c wkord : wkorderlst){
               wkordnames.add(wkord.name);
              // mapobj.put(wkord.id,wkord.name);
         }             
       
         /*   if(wkordnames.contains(wkord.name)){
                wrkordrec.Work_Order_Date__c = wkord.Work_Order_Date__c;
                //wrkordrec.Work_Order_Date__c = system.today();
                wrkordrec.Issued_To__c = wkord.Issued_To__c;
                wrkordrec.Vendor_ID__c = wkord.Vendor_ID__c;
                wrkordrec.Vendor_Quote__c = wkord.Vendor_Quote__c;
                wrkordrec.ABIS_Authorized_By__c = wkord.ABIS_Authorized_By__c;
                wrkordrec.Bill_To__c = wkord.Bill_To__c;
                wrkordrec.Ship_To__c = wkord.Ship_To__c;        
                //wrkordrec.Work_Order_Date__c = wkord.Work_Order_Date__c;
                
                system.debug('Value for wrkordrec' +wrkordrec );
                update wrkordrec; 
                system.debug('Value for wrkordrecfinal' +wrkordrec.id );
            }*/
            
                Work_Order__c wrkordrec = new Work_Order__c();
                wrkordrec.Work_Order_Date__c = Todaydate;
                //wrkordrec.Work_Order_Date__c = system.today();
                wrkordrec.Issued_To__c = finaljbpost.Account_Name__c;
                wrkordrec.Vendor_ID__c = finaljbpost.Opportunity__r.Account.Vendor_ID__c;
                wrkordrec.Vendor_Quote__c = Vnderquote;
                wrkordrec.ABIS_Authorized_By__c = wkord.ABIS_Authorized_By__c;
                wrkordrec.Bill_To__c = wkord.Bill_To__c;
                wrkordrec.Ship_To__c = wkord.Ship_To__c;        
                //wrkordrec.Work_Order_Date__c = wkord.Work_Order_Date__c;
                
                system.debug('Value for wrkordrec' +wrkordrec );
                insert wrkordrec; 
                system.debug('Value for wrkordrecfinal' +wrkordrec.id );
              
                
      if(Vndrlst.size()>0){
        List<Vendor_Sub_Costs__c> vlst = new List<Vendor_Sub_Costs__c>();
        //Map<id,Decimal>  mapobj = new Map<id, Decimal>();
        List<id>  vndrlstids = new List<id>();
        
           vlst = [Select Actual_Amount__c,Budgeted_Amount__c,Budgeted_Extended__c,
                        Comments__c,Count__c,Description__c,Difference__c,
                        Job_Cost__c,Line_Item__c,Unit_of_Measure__c
                        From Vendor_Sub_Costs__c where Job_Cost__c in: jobid]; 
                        
                        
            for(Vendor_Sub_Costs__c vdlst :vlst){
               //s mapobj.put(vdlst.id,vdlst.id + vdlst.Count__c);
                vndrlstids.add(vdlst.id);
            }          
            system.debug('Checkvndrlstidss' +  vndrlstids.size()); 
            system.debug('Checkvndrlst' +  Vndrlst.size());
            for(Vendor_Sub_Costs__c vndrlstt : Vndrlst){
           // Decimal Vndarhashkey = vndrlst.id + vndrlst.Count__c;
                  /*  if(vndrlstids.contains(vndrlstt.id)){
                    system.debug('CheckInside');
                Work_Order_Line_Item__c wrkitem = new Work_Order_Line_Item__c();
                        
                wrkitem.Line_Item__c = vndrlstt.Line_Item__c;
                wrkitem.Description__c = vndrlstt.Description__c;
                wrkitem.Quantity__c =   vndrlstt.Count__c;      
                wrkitem.Unit_Price__c =   vndrlstt.Budgeted_Amount__c;
                wrkitem.Taxed__c = taxedCheckbox;
                wrkitem.Work_Order__c = wrkordrec.id;    
                    system.debug('Value for wrkitem is: ' +wrkitem);
                        
                workitemlist.add(wrkitem);
                        system.debug('Value for workitemlist is: ' +workitemlist);
                        
                update   workitemlist; 
                }else{*/
                
                Work_Order_Line_Item__c wrkitem = new Work_Order_Line_Item__c();                        
                wrkitem.Line_Item__c = vndrlstt.Line_Item__c;
                wrkitem.Description__c = vndrlstt.Description__c;
                wrkitem.Quantity__c =   vndrlstt.Count__c;      
                wrkitem.Unit_Price__c =   vndrlstt.Budgeted_Amount__c;
                wrkitem.Taxed__c = taxedCheckbox;
                wrkitem.Work_Order__c = wrkordrec.id;    
                    
                workitemlist.add(wrkitem);
                insert   workitemlist; 
                
                
            }
        }
        system.debug('finalworkitemlist' + workitemlist);        
        //upsert   workitemlist;   
        
        //After this new Work Order record is saved -> Return the pagereference to View this record
        return New_VFPage();  
        
    } 
    
    public PageReference New_VFPage(){            
          Pagereference ref1 = new Pagereference('/' +wrkordrec.id);        
          ref1.setRedirect(true);
          return ref1;          
    }
    
}