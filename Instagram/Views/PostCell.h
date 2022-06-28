//
//  PostCell.h
//  Instagram
//
//  Created by Max Bagatini Alves on 6/27/22.
//

// Models
#import "PostViewModel.h"

// Frameworks
@import Parse;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) PostViewModel *postVM;

@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;

@end

NS_ASSUME_NONNULL_END
