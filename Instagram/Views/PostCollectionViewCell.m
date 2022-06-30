//
//  PostCollectionViewCell.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/30/22.
//

// Views
#import "PostCollectionViewCell.h"

// Frameworks
#import "UIImageView+AFNetworking.h"

@implementation PostCollectionViewCell

- (void) setPostVM:(PostViewModel *)postVM {
    _postVM = postVM;
    [self.postImage setImageWithURL:postVM.postImageUrl];
}

@end
