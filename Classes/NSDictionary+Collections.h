#import <Foundation/Foundation.h>


@interface NSDictionary (NSDictionary_Collections)

-(void)each:(void(^)(id key, id value))block;

@end
