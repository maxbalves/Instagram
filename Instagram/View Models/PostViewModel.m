//
//  PostViewModel.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/28/22.
//

// Frameworks
#import "UIImageView+AFNetworking.h"

// Models
#import "Post.h"

// View Models
#import "PostViewModel.h"

@implementation PostViewModel

- (instancetype) initWithPost:(Post *)post {
    self = [super init];
    if (!self) return nil;
    
    _post = post;
    
    PFFileObject *profilePic = [post.author valueForKey:@"profilePicture"];
    _profilePictureUrl = [NSURL URLWithString:profilePic.url];
    
    _username = post.author.username;
    
    _postImageUrl = [NSURL URLWithString:post.image.url];
    
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
