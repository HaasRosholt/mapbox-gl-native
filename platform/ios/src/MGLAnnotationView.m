#import "MGLAnnotationView.h"
#import "MGLAnnotationView_Private.h"

@interface MGLAnnotationView ()

@property (nonatomic, weak) id<MGLAnnotationViewDelegate> delegate;
@property (nonatomic, copy, nullable) NSString *reuseIdentifier;
@property (nonatomic) id<MGLAnnotation> annotation;

@end

@implementation MGLAnnotationView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)didTapView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint point = [tapGestureRecognizer locationInView:self];
        if ([self.delegate respondsToSelector:@selector(annotationView:didReceiveTapAtPoint:)])
        {
            [self.delegate annotationView:self didReceiveTapAtPoint:point];
        }
    }
}

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