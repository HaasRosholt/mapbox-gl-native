#import "MBXAnnotationView.h"

static const CGFloat MBXAnnotationViewSize = 35.0;
static const CGFloat MBXAnnotationViewPadding = 7.5;

@implementation MBXAnnotationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    CGRect frame = self.frame;
    frame.size.width = MBXAnnotationViewSize + MBXAnnotationViewPadding * 2;
    frame.size.height = MBXAnnotationViewSize + MBXAnnotationViewPadding * 2;
    self.frame = frame;
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = self.centerColor ?: [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor *color2 = [[UIColor alloc] initWithRed:0.258 green:0.909 blue:1.0 alpha:1.0];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(0.1, -2.1);
    shadow.shadowBlurRadius = 24.0;
    
    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(MBXAnnotationViewPadding, MBXAnnotationViewPadding, MBXAnnotationViewSize, MBXAnnotationViewSize)];
    [color setFill];
    [ovalPath fill];
    
    ////// Oval Inner Shadow
    CGContextSaveGState(context);
    CGContextClipToRect(context, ovalPath.bounds);
    CGContextSetShadow(context, CGSizeZero, 0);
   
    UIColor *shadowColor = shadow.shadowColor;
    CGContextSetAlpha(context, CGColorGetAlpha(shadowColor.CGColor));
    
    CGContextBeginTransparencyLayer(context, nil);
    UIColor *ovalOpaqueShadow = [shadowColor colorWithAlphaComponent:1];
    
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, ovalOpaqueShadow.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeSourceOut);
    CGContextBeginTransparencyLayer(context, nil);
    
    [ovalOpaqueShadow setFill];
    [ovalPath fill];
    
    CGContextEndTransparencyLayer(context);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    [color2 setStroke];
    ovalPath.lineWidth = MBXAnnotationViewPadding;
    [ovalPath stroke];
}

@end
