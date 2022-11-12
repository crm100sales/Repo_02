public  class workOrderExtensionTemp {
    
    //public  Work_Order__c wkord {get;set;} 
    public  Job_Cost__c jbpost {get;set;}
    //public  List<Vendor_Sub_Costs__c> Vndrlst  = new List<Vendor_Sub_Costs__c>();
    
    
    public workOrderExtensionTemp(ApexPages.StandardController stdController) {
        this.jbpost = (Job_Cost__c)stdController.getRecord();
        
        id jobpostId = jbpost.id;
        system.debug('Value for jobpostId is: ' + jobpostId);
        
        
        
       // jbpost = [SELECT id, name FROM Job_Cost__c
       //      WHERE id =: ApexPages.currentPage().getParameters().get('id')];
       
    }    
    
    public void clickMe(){
        system.debug('Entered clickMe method');
        New_VFPage();
    }
    
     public PageReference New_VFPage()
    {          
        system.debug('Entered New_VFPage method');
          Pagereference ref1 = new Pagereference('/apex/workOrderTestVFPage');
       // system.debug('Value for ref1 is: ' +ref1);
          //ref.getParameters().put('accountId', myCustomObject.Id);
         // ref1.getParameters().put('id',jbpost.id);  
        system.debug('Value for ref1 is: ' +ref1);
          //ref1.setRedirect(true);
          return ref1;
        //return new PageReference('/apex/workOrderTestVFPage');

    }
    
}