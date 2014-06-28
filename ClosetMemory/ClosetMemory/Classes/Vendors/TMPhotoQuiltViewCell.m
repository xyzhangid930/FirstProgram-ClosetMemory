

#import "TMPhotoQuiltViewCell.h"
#import "ResultList.h"

const CGFloat kTMPhotoQuiltViewMargin = 0;

@implementation TMPhotoQuiltViewCell

@synthesize photoView = _photoView;
@synthesize userView = _userView;
@synthesize titleLabel = _titleLabel;

- (void)dealloc
{
    [_photoView release], _photoView = nil;
    [_titleLabel release], _titleLabel = nil;
    [_userLabel release];
    [_userView release];
    [super dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)userView
{
    if (!_userView) {
        _userView = [[UIImageView alloc]init];
        _userView.clipsToBounds = YES;
        _userView.layer.cornerRadius = 20;
        _userView.layer.masksToBounds = YES;
        [_userView.layer setBorderWidth:1];
        [_userView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
        [self addSubview:_userView];
    }
    return _userView;
}
- (UILabel *)userLabel
{
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
//        _userLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        _userLabel.textColor = [UIColor blueColor];
        _userLabel.font = [UIFont systemFontOfSize:11];
        _userLabel.textAlignment = NSTextAlignmentLeft;
        _userLabel.numberOfLines = 0;
        [self addSubview:_userLabel];
    }
    return _userLabel;
}


- (void)layoutSubviews {
//    self.photoView.frame = CGRectInset(self.bounds, kTMPhotoQuiltViewMargin, kTMPhotoQuiltViewMargin);
    self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 60);
   
    self.titleLabel.frame = CGRectMake(5, self.bounds.size.height - 30,
                                       self.bounds.size.width, 30);
    self.userLabel.frame = CGRectMake(60, _photoView.frame.size.height, 100, 30);
    
     self.userView.frame = CGRectMake(20,  _photoView.frame.size.height-10, 40, 40);
    
}

@end
