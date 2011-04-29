#import <Foundation/Foundation.h>

@interface NSArray (NSArray_Collections)
-(NSArray *) map: (id(^)(id))block;
-(NSArray *) select: (bool(^)(id))block;
-(NSArray *) filter: (bool(^)(id))block;
-(NSArray *) each: (void(^)(id))block;
-(NSArray *) sort: (int(^)(id, id))block;
-(NSString *) join;
-(NSString *) join:(NSString *)separator;
-(id) first;
-(id) last;
@end
