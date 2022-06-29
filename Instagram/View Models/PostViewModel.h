//
//  PostViewModel.h
//  Instagram
//
//  Created by Max Bagatini Alves on 6/28/22.
//

// Frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Models
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostViewModel : NSObject

- (instancetype) initWithPost:(Post *) post;

+ (NSArray *)postVMsWithArray:(NSArray *)posts;

// TODO: add like / comment methods!!!

@property (strong, nonatomic) Post *post;

@property (strong, nonatomic, nullable) NSURL *profilePictureUrl;

@property (strong, nonatomic) NSString *username;

@property (strong, nonatomic) NSURL *postImageUrl;

@property (strong, nonatomic) NSString *caption;

@property (strong, nonatomic) NSString *likesLabel;

@property (strong, nonatomic) NSString *date;

@end

NS_ASSUME_NONNULL_END
