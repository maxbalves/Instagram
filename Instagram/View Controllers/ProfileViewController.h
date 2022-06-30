//
//  ProfileViewController.h
//  Instagram
//
//  Created by Max Bagatini Alves on 6/29/22.
//

// Frameworks
@import Parse;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFUser *user;

@end

NS_ASSUME_NONNULL_END
