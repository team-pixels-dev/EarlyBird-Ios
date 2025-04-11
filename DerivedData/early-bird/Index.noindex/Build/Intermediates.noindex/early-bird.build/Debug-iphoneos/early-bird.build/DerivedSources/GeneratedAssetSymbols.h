#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "LockIcon" asset catalog image resource.
static NSString * const ACImageNameLockIcon AC_SWIFT_PRIVATE = @"LockIcon";

/// The "circleBtn" asset catalog image resource.
static NSString * const ACImageNameCircleBtn AC_SWIFT_PRIVATE = @"circleBtn";

/// The "circleBtn2" asset catalog image resource.
static NSString * const ACImageNameCircleBtn2 AC_SWIFT_PRIVATE = @"circleBtn2";

/// The "fireIcon" asset catalog image resource.
static NSString * const ACImageNameFireIcon AC_SWIFT_PRIVATE = @"fireIcon";

/// The "lineArrowIcon" asset catalog image resource.
static NSString * const ACImageNameLineArrowIcon AC_SWIFT_PRIVATE = @"lineArrowIcon";

/// The "mascotAngryFace" asset catalog image resource.
static NSString * const ACImageNameMascotAngryFace AC_SWIFT_PRIVATE = @"mascotAngryFace";

/// The "mascotNormalFace" asset catalog image resource.
static NSString * const ACImageNameMascotNormalFace AC_SWIFT_PRIVATE = @"mascotNormalFace";

/// The "mascotSmileFace" asset catalog image resource.
static NSString * const ACImageNameMascotSmileFace AC_SWIFT_PRIVATE = @"mascotSmileFace";

/// The "onboardMascot" asset catalog image resource.
static NSString * const ACImageNameOnboardMascot AC_SWIFT_PRIVATE = @"onboardMascot";

/// The "splash" asset catalog image resource.
static NSString * const ACImageNameSplash AC_SWIFT_PRIVATE = @"splash";

#undef AC_SWIFT_PRIVATE
