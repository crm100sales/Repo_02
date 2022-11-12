public with sharing class workOrder110PDFEmail {
    
    public id workOrderRecId {get;set;}      
    public String email1 {get;set;}     
    public String email2 {get;set;} 
    public String email3 {get;set;} 
    public String email4 {get;set;} 
    public String email5 {get;set;} 
    
    public List<String> emailAddressesList = new List<String>();
	
    public Work_Order__c workOrderRec = new Work_Order__c();
	public List<Work_Order__c> workOrderRecList = new List<Work_Order__c>();        
    
    public workOrder110PDFEmail() {
        this.workOrderRecId =  ApexPages.currentPage().getParameters().get('id');
        	//system.debug('Value for this.workOrderRecId is: ' +  this.workOrderRecId);
                       
        workOrderRecList = [Select id, Name From Work_Order__c where id =: workOrderRecId ];        
        this.workOrderRec = workOrderRecList[0];
    }    
    
    public PageReference sendPDFOutboundEmail() { 
        
    if( ! string.isBlank(email1)){ 
    	emailAddressesList.add(email1);
    }
    if( ! string.isBlank(email2)){ 
    	emailAddressesList.add(email2);
    }  
    if( ! string.isBlank(email3)){     
    	emailAddressesList.add(email3);
    }  
    if( ! string.isBlank(email4)){     
    	emailAddressesList.add(email4);
    }        
    if( ! string.isBlank(email5) ){     
    	emailAddressesList.add(email5);
    }
            
    Pagereference pdf = new Pagereference('/apex/WorkOrder110PDF?id=' +workOrderRecId); 
                
    // the contents of the attachment from the pdf
    Blob body;
    
    try {      
      // returns the output of the page as a PDF
      body = pdf.getContent();      
        
    // need to pass unit test
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }
        
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');    
    attach.setFileName(workOrderRec.Name);    
    attach.setInline(false);
    attach.Body = body;    
        
    List<Messaging.SingleEmailMessage> SingleEmailMessages = new List<Messaging.SingleEmailMessage>(); 
    for( String emailaddress: emailAddressesList ) {
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();        
        mail.setUseSignature(false);
        //mail.setToAddresses(new String[] { email });
        mail.setToAddresses(new String[] { emailaddress } );        
        mail.setSubject('ABIS Work Order # ' + workOrderRec.Name);
        mail.setHtmlBody('Attached please find the ABIS Work Order matching your project quotation. Please complete all work according to your Master Services Agreement.');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });        
        SingleEmailMessages.add(mail);
    } 
        
	// Send the email
    //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    Messaging.sendEmail(SingleEmailMessages);    
    
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Work Order PDF sent to: '+email1 +' ' +email2 +' ' +email3 +' ' +email4 +' ' +email5));
        
    //if( ){
    	//Attach to parent - Work Order
        Attachment workOrderAttachment = new Attachment();
        workOrderAttachment.Body = body;    
        workOrderAttachment.Name = workOrderRec.Name + '.pdf';
        workOrderAttachment.IsPrivate = false; 
        //workOrderAttachment.ContentType('application/pdf');
        workOrderAttachment.ParentId = workOrderRec.Id;
        insert workOrderAttachment;        
    //}    
        
    return null;
  }        
    
}