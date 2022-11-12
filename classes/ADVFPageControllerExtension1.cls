public class ADVFPageControllerExtension1{

        public user user1 {get; set;}
        public String username1{get; set;}
        public String username2{get; set;}
        public String username3{get; set;}
        public String username4{get; set;}
        public String username5{get; set;}
        public String username6{get; set;}
        public String username7{get; set;}
        public String username8{get; set;}
        public String username0{get; set;}
        public String username9{get; set;}
        public String username12{get; set;}
 
 
 // 
 
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String company {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }

    
    public ADVFPageControllerExtension1(){
    }
    
    public ADVFPageControllerExtension1(APEXPages.StandardController Controller ){
     user1 = new user();     
	}
        
    private boolean isValidPassword() {
        return password == confirmPassword;
    }

    public PageReference save1(){   
         // it's okay if password is null - we'll send the user a random password in that case
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'do not match');
            ApexPages.addMessage(msg);
            return null;
        }    

        String profileId = null; // To be filled in by customer.
        String roleEnum = null; // To be filled in by customer.
        String accountId = ''; // To be filled in by customer.

        String userName = email;

        User u = new User();
        u.Username = userName;
        u.Email = email;
        u.FirstName = firstName;
        u.LastName = lastName;
        u.CommunityNickname = communityNickname;
        u.ProfileId = profileId;
        u.CompanyName = company;

        String userId = Site.createPortalUser(u, accountId, password);

        if (userId != null) { 
            if (password != null && password.length() > 1) {
                return Site.login(userName, password, null);
            }
            else {
                PageReference page = System.Page.CommunitiesSelfRegConfirm;
                page.setRedirect(true);
                return page;
            }
        }
        return null;
    }
    
    public void searchUser(){        
        system.debug('Value for username1 is: ' +username1);        
       // Pagereference pr = new Pagereference('/apex/ADVFPage/');
        //pr.setRedirect(false);
        //return pr;
    }
}