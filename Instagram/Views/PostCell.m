//
//  PostCell.m
//  Instagram
//
//  Created by Max Bagatini Alves on 6/27/22.
//

#import "PostCell.h"
#import "PostViewModel.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setPostVM:(PostViewModel *)postVM {
    _postVM = postVM;
    self.profilePicture.image = postVM.profilePicture;
    self.username.text = postVM.username;
    self.postImage.image = postVM.postImage;
    self.caption.text = postVM.caption;
    self.date.text = postVM.date;
    self.likesLabel.text = postVM.likesLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
