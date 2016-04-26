#import "MBXAnnotationView.h"

@interface MBXAnnotationView ()

@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation MBXAnnotationView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.centerView.layer.cornerRadius = CGRectGetWidth(self.centerView.bounds) / 2.0;
}

- (void)setCenterColor:(UIColor *)centerColor {
    if (![_centerColor isEqual:centerColor]) {
        _centerColor = centerColor;
        self.centerView.backgroundColor = centerColor;
    }
}

@end
