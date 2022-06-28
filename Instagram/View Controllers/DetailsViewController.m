//
//  DetailsViewController.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/28/22.
//

// View Controllers
#import "DetailsViewController.h"

// View Models
#import "PostViewModel.h"

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet UILabel *date;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilePicture.image = self.postVM.profilePicture;
    self.username.text = self.postVM.username;
    self.postImage.image = self.postVM.postImage;
    self.caption.text = self.postVM.caption;
    self.date.text = self.postVM.date;
    self.likeLabel.text = self.postVM.likesLabel;
}

@end
