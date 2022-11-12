public class AccountListCmp02 {
    
    //New methods added
    
    @AuraEnabled
    public static DMLResponseAura getfetchResults(){    
	
	List <TestIntegration_cs__x> tstIntegrationList = new List <TestIntegration_cs__x>();
	
		String searchQuery = 'Select' + ' IntegratName_c__c, IntegrationNo_c__c, IntegrationEmail_c__c, IntegrationDate_c__c, Category_c__c, (select id, externalid, Name__c, Amount_c__c, TestIntegration_c__c from TestIntegrationChild_cs__r ) '  + ' From TestIntegration_cs__x ' + ' Limit 3 ' ;
      
        //searchQuery += ' Order by '        
        tstIntegrationList = Database.query(searchQuery);
        
        system.debug('Value for tstIntegrationList is: ' +tstIntegrationList);
        return new DMLResponseAura ('Success', JSON.Serialize(tstIntegrationList) );
    }
    
    @AuraEnabled
    public static DMLResponseAura getSOSLfetchBothTables(String srchTerm, Boolean searchTerm1, Boolean searchTerm2, Boolean searchTerm3){    
	
	List <TestIntegration_cs__x> tstIntegrationList = new List <TestIntegration_cs__x>();
	
       
          String whereClause = ' where Category_c__c IN ( '  + ' \'Category2\' '  + ' , '   + ' \'Category3\' ' + ' ) ' ;
        
        //Sub query code added
        String searchQuery = 'Select' + ' IntegratName_c__c, IntegrationNo_c__c, IntegrationEmail_c__c, IntegrationDate_c__c, Category_c__c, (select id, externalid, Name__c, Amount_c__c, TestIntegration_c__c from TestIntegrationChild_cs__r ) '  + ' From TestIntegration_cs__x ' + whereClause + ' Limit 3' ;
        
        system.debug('Value for searchQuery is: ' +searchQuery);
    
        //searchQuery += ' Order by '        
        tstIntegrationList = Database.query(searchQuery);
        
        system.debug('Value for tstIntegrationList is: ' +tstIntegrationList);
        return new DMLResponseAura ('Success', JSON.Serialize(tstIntegrationList ) );
    }
        
    @AuraEnabled
    public static DMLResponseAura getSOSLfetchSearchResults(String srchTerm){    
	
	List <TestIntegration_cs__x> tstIntegrationList = new List <TestIntegration_cs__x>();
	//Field list
	//List<String> fieldList =  CustomUtilityClass01.getFieldList('TestIntegration');
	
    //Condition	 
	List<String> conditionList = CustomUtilityClass01.getSOSLSearchFields('SearchFields',srchTerm );
        String conditionalString = ' ( ' + String.join(conditionList, 'OR') +  ' ) '  ;
        
		String searchQuery = 'Select' + ' IntegratName_c__c, IntegrationNo_c__c ' + ' From TestIntegration_cs__x where IntegratName_c__c = ' + '\'' +srchTerm + '\'' ;
        
        system.debug('Value for searchQuery is: ' +searchQuery);
/*        if (conditionalString != '' && != null ){
        	searchQuery += ' AND ' +   conditionalString; 
        }
*/        
        //searchQuery += ' Order by '        
        tstIntegrationList = Database.query(searchQuery);
        
        system.debug('Value for tstIntegrationList is: ' +tstIntegrationList);
        return new DMLResponseAura ('Success', JSON.Serialize(tstIntegrationList ) );
    }
    
    @AuraEnabled
    public static DMLResponseAura submitTestIntegration01 (String submitString){ 
    	system.debug('Value for submitString is: ' +submitString);
    	
        
		String JSONResponse = '' ;
        
        //String mockJSONResponse = '{ "glossary": { "title": "example glossary"  } }' ;
        //String mockJSONResponse = '{ "field02":{ "first": "Value200", "second":"Value201", "third": "Value202" } }' ;
       // String mockJSONResponse = '{ "field02":{ "first": "Value200", "second":"Value201", "third": "Value202" }, "field03":	[ {"first": "Value300","second":"Value301","third": "Value302"	}, {"first": "Value310", "second":"Value311", "third": "Value312" } ] }' ; 
        String mockJSONResponse = '{	"field02":{ "first": "Value200", "second":"Value201", "third": "Value202" }, "field03": 	[	{"first": "Value300","second":"Value301","third": "Value302"},	{"first": "Value310","second":"Value311","third": "Value312"},	{"first": "Value320","second":{ "fourth": "Value3211","fifth" : "Value3212"	},"third": [ {"fourth": "Value3221",	"fifth" : "Value3222","sixth" : "Value3223"	},{"fourth": "Value3231",	"fifth" : "Value3232","sixth" : "Value3233"	}]	}	] } ';
        //return new DMLResponseAura ('Success', JSON.Serialize(JSONResponse) );
        //return new DMLResponseAura ('Success', JSON.Serialize(mockJSONResponse) );
        return new DMLResponseAura ('Success', mockJSONResponse );
    }    
    
    
    /* Fetching Child Data */    
    @AuraEnabled
    public static DMLResponseAura getchilddata(String Externalid){    
	system.debug('value passed externalid' +  Externalid);
	List <TestIntegrationChild_cs__x> tstIntegrationList = new List <TestIntegrationChild_cs__x>();
	    String searchQuery = 'select id, externalid, Name__c, Amount_c__c, TestIntegration_c__c ' + ' From TestIntegrationChild_cs__x where TestIntegration_cs__c = ' + '\'' +Externalid + '\'' ;
        
        system.debug('Value for searchQuery is: ' +searchQuery);       
        tstIntegrationList = Database.query(searchQuery);
        
        system.debug('Value for tstIntegrationList is: ' +tstIntegrationList);
        return new DMLResponseAura ('Success', JSON.Serialize(tstIntegrationList ) );
    }
    
    
    @AuraEnabled
    public static DMLResponseAura getSOSLfetchListCheckbox(String srchTerm, Boolean searchTerm1, Boolean searchTerm2, Boolean searchTerm3){    
	
	List <TestIntegration_cs__x> tstIntegrationList = new List <TestIntegration_cs__x>();
	
       
          String whereClause = ' where Category_c__c IN ( '  + ' \'Category2\' '  + ' , '   + ' \'Category3\' ' + ' ) ' ;
       
         String searchQuery = 'Select' + ' IntegratName_c__c, IntegrationNo_c__c, IntegrationEmail_c__c, IntegrationDate_c__c, Category_c__c '  + ' From TestIntegration_cs__x ' + whereClause + ' Limit 10 ' ;
        
        system.debug('Value for searchQuery is: ' +searchQuery);
/*        if (conditionalString != '' && != null ){
        	searchQuery += ' AND ' +   conditionalString; 
        }
*/        
        //searchQuery += ' Order by '        
        tstIntegrationList = Database.query(searchQuery);
        
        system.debug('Value for tstIntegrationList is: ' +tstIntegrationList);
        return new DMLResponseAura ('Success', JSON.Serialize(tstIntegrationList ) );
    }
 
    
    
	@AuraEnabled
    public static List<TestIntegration_cs__x> fetchSearchResults(){      
    	List<TestIntegration_cs__x> acclst = [Select IntegratName_c__c, IntegrationNo_c__c, IntegrationEmail_c__c, IntegrationDate_c__c from TestIntegration_cs__x];
        system.debug('Value for acclst ' +acclst);
     	return acclst ;          
    }
    
    /*
	Method Name	: getExternalobjectrecords
	Purpose		: To get the wrapper of Columns and Headers
	*/
    //public List<TestIntegration_cs__x> acclst{get;set;}
    
    @AuraEnabled
    public static DataTableResponse getAccRecords(String strObjectName, String strFieldSetName){                
       	
        //Get the fields from FieldSet
        Schema.SObjectType SObjectTypeObj = Schema.getGlobalDescribe().get(strObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();            
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(strFieldSetName);
        
        //To hold the table headers 
        List<DataTableColumns> lstDataColumns = new List<DataTableColumns>();
        
        //Field to be queried - fetched from fieldset
        List<String> lstFieldsToQuery = new List<String>();
        
        //The final wrapper response to return to component
        DataTableResponse response = new DataTableResponse();
        
        for( Schema.FieldSetMember eachFieldSetMember : fieldSetObj.getFields() ){
            String dataType = String.valueOf(eachFieldSetMember.getType()).toLowerCase();
            //This way we can set the type of a column
            //We do not get the exact type from schema object which matches to lightning:datatable component structure
            if(dataType == 'datetime'){
                dataType = 'date';
            }
            //Create a wrapper instance and store label, fieldname and type.
            DataTableColumns datacolumns = new DataTableColumns( String.valueOf(eachFieldSetMember.getLabel()) , 
                                                                String.valueOf(eachFieldSetMember.getFieldPath()), 
                                                                String.valueOf(eachFieldSetMember.getType()).toLowerCase() );
			lstDataColumns.add(datacolumns);
            lstFieldsToQuery.add(String.valueOf(eachFieldSetMember.getFieldPath()));
        }
        //Form an SOQL to fetch the data - Set the wrapper instance and return as response
        if(! lstDataColumns.isEmpty()){            
            response.lstDataTableColumns = lstDataColumns;
            String query = 'SELECT Id, ' + String.join(lstFieldsToQuery, ',') + ' FROM TestIntegration_cs__x';
            System.debug(query);
            response.lstDataTableData = Database.query(query);
        }
        
        return response;
    }
    
    //Wrapper class to hold Columns with headers
    public class DataTableColumns {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled       
        public String fieldName {get;set;}
        @AuraEnabled
        public String type {get;set;}
        
        //Create and set three variables label, fieldname and type as required by the lightning:datatable
        public DataTableColumns(String label, String fieldName, String type){
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;            
        }
    }
    
    //Wrapper calss to hold response - This response is used in the lightning:datatable component
    public class DataTableResponse {
        @AuraEnabled
        public List<DataTableColumns> lstDataTableColumns {get;set;}
        @AuraEnabled
        public List<sObject> lstDataTableData {get;set;}                
        
        public DataTableResponse(){
            lstDataTableColumns = new List<DataTableColumns>();
            lstDataTableData = new List<sObject>();
        }
    }
    
    @AuraEnabled
    public static List<TestIntegration_cs__x> findByName(String searchKey, Account[] accList) {
        List<sObject> datatablelst = new List<sObject>();
        Set<Id> recordIds = new Set<Id>();
      DataTableResponse   datatable = AccountListCmp02.getAccRecords('TestIntegration_cs__x','ExternalFieldset');
        datatablelst = datatable.lstDataTableData;
        for(sObject ts : datatablelst){
                recordIds.add(ts.id);           
            
        }
        //List<Id> recordIds = new Map<Id, DataTableResponse>(getAccRecords('TestIntegration_cs__x','ExternalFieldset');
        //system.debug('ACCOUNT LIST' + accList);
        String name = '%' + searchKey + '%';
        return [Select Id, Name__c from TestIntegration_cs__x WHERE (Name__c LIKE :name) AND Id IN:recordIds LIMIT 50];
    }
    
    @AuraEnabled
    public static List<TestIntegration_cs__x> getshowacc(){      
    	List<TestIntegration_cs__x> acclst = [Select IntegratName_c__c, IntegrationNo_c__c, IntegrationEmail_c__c, IntegrationDate_c__c from TestIntegration_cs__x];
        system.debug('Value for acclst ' +acclst);
     	return acclst ;          
    }
    
}