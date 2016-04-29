#import "MGLAnnotationView.h"
#import "MGLAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MGLAnnotationViewDelegate <NSObject>

- (void)annotationView:(MGLAnnotationView *)annotationView didReceiveTapAtPoint:(CGPoint)point;

@end

@interface MGLAnnotationView (Private)

@property (nonatomic, weak) id<MGLAnnotationViewDelegate> delegate;

// Identifier used to specifiy a reuse queue for the annotation view type.
@property (nonatomic, copy, nullable) NSString *reuseIdentifier;

@property (nonatomic) id<MGLAnnotation> annotation;

@end

NS_ASSUME_NONNULL_END
