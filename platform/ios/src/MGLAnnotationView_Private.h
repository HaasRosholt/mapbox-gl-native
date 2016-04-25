#import "MGLAnnotationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGLAnnotationView (Private)

// Identifier used to specifiy a reuse queue for the annotation view type.
@property (nonatomic, copy, nullable) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
