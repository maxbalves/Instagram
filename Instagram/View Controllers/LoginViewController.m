//
//  LoginViewController.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/27/22.
//

// View Controllers
#import "LoginViewController.h"

// Frameworks
@import Parse;

// Delegates
#import "SceneDelegate.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerUser:(id)sender {
    // initialize user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    UIImage *img = [UIImage imageNamed:@"profile_tab.png"];
    NSData *img_data = UIImagePNGRepresentation(img);
    PFFileObject *profilePicture = [PFFileObject fileObjectWithName:@"profilePicture.png" data:img_data];;
    
    [newUser setValue:profilePicture forKey:@"profilePicture"];
    
    // validity check
    if ([self isBlankUsername:newUser.username password:newUser.password]) {
        // stop function
        return;
    }
    
    // call sign up function on object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                // manually segue to logged in view
                [self presentHome];
            }
    }];
    
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    // validity check
    if ([self isBlankUsername:username password:password]) {
        // stop function
        return;
    }
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            // display view controller that needs to shown after successful login
            [self presentHome];
            
        }
    }];
}

- (BOOL) isBlankUsername:(NSString *)username password:(NSString *)password {
    if ([username isEqualToString:@""]) {
        [self showAlertWithTitle:@"Username Required" message:@"Please enter your username"];
        return YES;
    } else if ([password isEqualToString:@""]) {
        [self showAlertWithTitle:@"Password Required" message:@"Please enter your password"];
        return YES;
    }
    return NO;
}

- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // do nothing
    }];
}

- (void) presentHome {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    mySceneDelegate.window.rootViewController = tabBarController;
}

@end
