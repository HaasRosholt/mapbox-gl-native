#import "MGLAnnotationView.h"
#import "MGLAnnotationView_Private.h"

@interface MGLAnnotationView ()

@property (nonatomic, copy, nullable) NSString *reuseIdentifier;

@end

@implementation MGLAnnotationView

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    // Allow mbgl to drive animation of this view’s bounds.
    if ([event isEqualToString:@"bounds"])
    {
        return [NSNull null];
    }
    return [super actionForLayer:layer forKey:event];
}

@end