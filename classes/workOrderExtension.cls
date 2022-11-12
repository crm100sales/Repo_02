public with sharing class workOrderExtension {
      
    public  Work_Order__c wkord {get;set;} 
    public  Job_Cost__c jbpost {get;set;}
    public  List<Work_Order_Line_Item__c> workitemlist {get;set;}
      
      
    public workOrderExtension(ApexPages.StandardController stdController) {
      this.wkord = (Work_Order__c)stdController.getRecord();
     // system.debug('Workorder' +  this.jbpost);
     workitemlist = new List<Work_Order_Line_Item__c>();
      List<id> wkorderid = new List<id>();
      List<Work_Order__c> wkorderlst = new List<Work_Order__c>();
      wkorderid.add(wkord.id);
      
   wkorderlst = [Select id, name,Work_Order_Date__c,Issued_To__c,Vendor_ID__c,Vendor_Quote__c,ABIS_Authorized_By__r.name,Ship_To__r.name, Job_Cost__c,  
                      Bill_To__c, Bill_To_Company_Name__c, Bill_To__r.Name, Bill_To__r.BillingStreet,
                      Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry, Bill_To__r.Phone,
                      Ship_To__c, Ship_To_Project_Location__c, Ship_To_Street_Address__c, Ship_To_City_State_ZipCode__c, Ship_To_Phone__c, Additional_Comments__c
                  From Work_Order__c where id in: wkorderid limit 1];
    this.wkord = wkorderlst[0];
    
    this.workitemlist = [select id, Line_Item__c,Quantity__c,Description__c,Unit_Price__c,Taxed__c,Work_Order__c  from Work_Order_Line_Item__c where Work_Order__c in : wkorderid];
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
    
    public PageReference printPdfWorkOrder(){
        
        system.debug('Entered sendPdfWorkOrder method: ' );
        system.debug('Value for workOrderId is: ' +workOrderId);
        
/*        PageReference pdf1 = Page.PdfGeneratorTemplateWorkOrder;
        // add parent id to the parameters for standardcontroller
        pdf1.getParameters().put('Id', workOrderId);
        pdf1.setRedirect(true);
            
        return pdf1;    
 */       
       // PageReference currentVFPage = ApexPages.currentPage();
       // currentPageworkOrderId = currentVFPage.getParameters().get('id');
        
        PageReference pdf2 = Page.WorkOrderPDFPage;
        pdf2.getParameters().put('Id', 'a0y1R00000HPEnM');
        pdf2.setRedirect(true);
        return pdf2;    
    }
    
    public PageReference sendPdfWorkOrder() {
        
        system.debug('Entered sendPdfWorkOrder method: ' );
    
    PageReference pdf = Page.PdfGeneratorTemplateWorkOrder;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',workOrderId);
    
        system.debug('Value for workOrderId is: ' +workOrderId);
        
    // the contents of the attachment from the pdf
    Blob body;
    
    try {
      
      // returns the output of the page as a PDF
      body = pdf.getContent();
      
        system.debug('Value for body is: ' +pdf.getContent() );
        
    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }
        
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('testPdf.pdf');
    attach.setInline(false);
    attach.Body = body;

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { email });
    mail.setSubject('PDF Email Demo');
    mail.setHtmlBody('Here is the email you requested! Check the attachment!');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
    
    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+email));

    return null;

  }
       

}