//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Max Bagatini Alves on 6/30/22.
//

// Views
#import "PostViewModel.h"

// Frameworks
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) PostViewModel *postVM;
@property (strong, nonatomic) IBOutlet UIImageView *postImage;

@end

NS_ASSUME_NONNULL_END
