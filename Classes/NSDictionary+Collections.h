#import <Foundation/Foundation.h>


@interface NSDictionary (NSDictionary_Collections)

-(void)each:(void(^)(id key, id value))block;
-(void)eachKey:(void(^)(id key))block;
-(void)eachValue:(void(^)(id value))block;
-(NSDictionary *)filter:(BOOL(^)(id key, id value))block;
-(NSDictionary *)first:(BOOL(^)(id key, id value))block;
-(NSDictionary *)mapValues:(id(^)(id value))block;

@end
