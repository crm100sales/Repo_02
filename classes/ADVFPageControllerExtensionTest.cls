@isTest
private class ADVFPageControllerExtensionTest {
    
    static testMethod void testMethodPositive() {
                
        //Set up user
        //User u1 = [SELECT Id FROM User WHERE Alias='auser'];
        //*** Create a user from scratch and then assign the Profile to it (ex: System Administrator)        
        
        //Run As U1
        //System.RunAs(u1){        
            ADVFPageControllerExtension advf = new ADVFPageControllerExtension();
            
            Test.startTest();
                advf.isValidPassword();
                advf.save1();
                advf.searchUser();
            Test.stopTest();
        
        	//System.assertEquals(singletotalMiles, totalMiles); -> singletotalMiles is the variable value and totalMiles is the calculated value

       //}
        
    }

    static testMethod void testMethodNegative() {
                
        //Set up user
        //User u1 = [SELECT Id FROM User WHERE Alias='auser'];
        //*** Create a user from scratch and then assign the Profile to it (ex: System Administrator)        
        
        //Run As U1
        //System.RunAs(u1){        
            ADVFPageControllerExtension advf = new ADVFPageControllerExtension();
            
        	//Email id value is incorrect
        	
            Test.startTest();
                advf.isValidPassword();
                advf.save1();
                advf.searchUser();
            Test.stopTest();
       //}
        
    }

}