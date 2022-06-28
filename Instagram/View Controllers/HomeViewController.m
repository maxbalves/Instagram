//
//  HomeViewController.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/27/22.
//

// View Controllers
#import "DetailsViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"

// Frameworks
@import Parse;

// Views
#import "PostCell.h"

// View Models
#import "PostViewModel.h"

// Delegates
#import "SceneDelegate.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfPostVMs;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) int MAX_POSTS_SHOWN;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.MAX_POSTS_SHOWN = 20;
    
    self.refreshControl = [UIRefreshControl new];
    
    [self.refreshControl addTarget:self action:@selector(refreshFeed:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self refreshFeed:self.refreshControl];
}

- (void) refreshFeed:(UIRefreshControl *)refreshControl {
    [refreshControl beginRefreshing];
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = self.MAX_POSTS_SHOWN;
    [query orderByDescending:@"createdAt"];
    [query includeKeys:@[@"author"]];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPostVMs = [PostViewModel postVMsWithArray:posts];
            [self.tableView reloadData];
            [refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPostVMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.postVM = self.arrayOfPostVMs[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Prevents cell from having gray background due to being selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 == self.arrayOfPostVMs.count && self.arrayOfPostVMs.count == self.MAX_POSTS_SHOWN) {
        self.MAX_POSTS_SHOWN += 20;
        
        [self refreshFeed:self.refreshControl];
    }
}

- (IBAction)logoutUser:(id)sender {
    // PFUser.current() will now be nil
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
        mySceneDelegate.window.rootViewController = loginVC;
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostDetailSegue"]) {
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.postVM = self.arrayOfPostVMs[[self.tableView indexPathForCell:sender].row];
    }
}

@end
