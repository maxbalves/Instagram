//
//  PostViewModel.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/28/22.
//

// Models
#import "Post.h"

// View Models
#import "PostViewModel.h"

@implementation PostViewModel

- (instancetype) initWithPost:(Post *)post {
    self = [super init];
    if (!self) return nil;
    
    _post = post;
    
    // TODO: Implement Profile Pictures
     _profilePicture = nil;
    _username = post.author.username;

    /*
     @property (strong, nonatomic) UIImage *profilePicture;
     */
    
    // TODO: AFNetworking or Delegate Cell
    _postImage = [UIImage imageWithData:[post.image getData]];
    
    _caption = post.caption;
    _likesLabel = [NSString stringWithFormat:@"%@ likes", post.likeCount];
    
    _date = [NSString stringWithFormat:@"%@", post.createdAt];
    
    return self;
}

+ (NSArray *) postVMsWithArray:(NSArray *)posts {
    NSMutableArray *postVMsArray = [NSMutableArray new];
    for (Post *post in posts) {
        PostViewModel *postVM = [[PostViewModel alloc] initWithPost:post];
        [postVMsArray addObject:postVM];
    }
    return postVMsArray;
    
}

@end
