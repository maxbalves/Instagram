//
//  DetailsViewController.h
//  Instagram
//
//  Created by Max Bagatini Alves on 6/28/22.
//

// View Models
#import "PostViewModel.h"

// Frameworks
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) PostViewModel *postVM;

@end

NS_ASSUME_NONNULL_END
