//
//  ProfileViewController.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/29/22.
//

// Views
#import "PostCollectionViewCell.h"

// View Model
#import "PostViewModel.h"

// View Controllers
#import "ProfileViewController.h"

// Frameworks
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSArray *arrayOfPostVMs;
@property (nonatomic) int MAX_POSTS_SHOWN;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    if (self.user == nil) {
        self.user = PFUser.currentUser;
    }
    self.username.text = self.user[@"username"];
    
    PFFileObject *profilePic = [self.user valueForKey:@"profilePicture"];
    NSURL *profilePicUrl = [NSURL URLWithString:profilePic.url];
    [self.profilePicture setImageWithURL:profilePicUrl];
    
    self.MAX_POSTS_SHOWN = 20;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(queryUserPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    [self queryUserPosts];
}

- (void) queryUserPosts {
    [self.refreshControl beginRefreshing];
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = self.MAX_POSTS_SHOWN;
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.user];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPostVMs = [PostViewModel postVMsWithArray:posts];
            [self.collectionView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (PostCollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    cell.postVM = self.arrayOfPostVMs[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfPostVMs.count;
}

@end
