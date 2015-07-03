//
//  EasyEaseAnimation.m
//
//  Created by Irimasu Densan Planning on 11/03/01.
//

#import "EasyEaseAnimation.h"

@interface EasyEaseAnimation (private)

- (void)calculateKeyFramesWithBlock:(easeblock_t)easyease
                             params:(NSDictionary*)params
                         startValue:(CGFloat)startValue
                           endValue:(CGFloat)endValue
                  interstitialSteps:(NSUInteger)steps
                         beginSteps:(NSUInteger)beginSteps;
@end 

@implementation EasyEaseAnimation

+ (id)animationWithKeyPath:(NSString *)keyPath
				startValue:(CGFloat)startValue
				  endValue:(CGFloat)endValue
					 block:(easeblock_t)easyease
					params:(NSDictionary*)params
		 interstitialSteps:(NSUInteger)steps
{
	id animation = [super animationWithKeyPath:keyPath];

	[animation	calculateKeyFramesWithBlock:easyease
				 params:params
				 startValue:startValue
				 endValue:endValue - startValue
				 interstitialSteps:steps
				 beginSteps:0];
	
	return animation;
}

+ (id)animationWithKeyPath:(NSString *)keyPath
				startValue:(CGFloat)startValue
				  endValue:(CGFloat)endValue
					 block:(easeblock_t)easyease
					params:(NSDictionary*)params
		 interstitialSteps:(NSUInteger)steps
				beginSteps:(NSUInteger)beginSteps
{
	id animation = [super animationWithKeyPath:keyPath];
	
	[animation	calculateKeyFramesWithBlock:easyease
									params:params
								startValue:startValue
								  endValue:endValue - startValue
						 interstitialSteps:steps
								beginSteps:beginSteps];
	
	return animation;
}

- (id)initWithKeyPath:(NSString *)keyPath
           startValue:(CGFloat)startValue
             endValue:(CGFloat)endValue
                block:(easeblock_t)easyease
               params:(NSDictionary*)params
    interstitialSteps:(NSUInteger)steps
{
    id animation = [super init];
    if( animation != nil ){
        ((CAKeyframeAnimation*)animation).keyPath = keyPath;
        [animation	calculateKeyFramesWithBlock:easyease
                                        params:params
                                    startValue:startValue
                                      endValue:endValue - startValue
                             interstitialSteps:steps
                                    beginSteps:0];    
    }
    return animation;
}

- (id) initWithKeyPath:(NSString *)keyPath
            startValue:(CGFloat)startValue
              endValue:(CGFloat)endValue
                 block:(easeblock_t)easyease
                params:(NSDictionary*)params
     interstitialSteps:(NSUInteger)steps
			beginSteps:(NSUInteger)beginSteps
{
    id animation = [super init];
    if( animation ){
        ((CAKeyframeAnimation*)animation).keyPath = keyPath;
        [animation	calculateKeyFramesWithBlock:easyease
                                        params:params
                                    startValue:startValue
                                      endValue:endValue - startValue
                             interstitialSteps:steps
                                    beginSteps:beginSteps];
    }
    return animation;
}

- (void)calculateKeyFramesWithBlock:(easeblock_t)easyease
					params:(NSDictionary*)params
					startValue:(CGFloat)startValue
					endValue:(CGFloat)endValue
					interstitialSteps:(NSUInteger)steps
					beginSteps:(NSUInteger)beginSteps
{
	NSUInteger count = steps + 2;
	
	NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:beginSteps + count];
	
	const CGFloat max_progress = 1.0f;
	CGFloat progress = 0.0;
	CGFloat increment = max_progress / (double)(count - 1);
	
	NSUInteger i;
	for (i = 0; i < beginSteps; i++)
		[valueArray addObject:[NSNumber numberWithDouble:startValue]];
	
	for (i = 0; i < count; i++){
		CGFloat value = easyease(progress,startValue,endValue,max_progress ,params);
		[valueArray addObject:[NSNumber numberWithDouble:value]];
		progress += increment;
	}
	
	[self setValues:valueArray];
}

@end
