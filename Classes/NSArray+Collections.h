#import <Foundation/Foundation.h>

@interface NSArray (NSArray_Collections)
-(NSArray *) map:(id(^)(id))block;
-(id) reduce:(id(^)(id value, id object))block initial:(id)initial;
-(NSArray *) select:(BOOL(^)(id))block;
-(NSArray *) filter:(BOOL(^)(id))block;
-(NSArray *) each:(void(^)(id))block;
-(NSArray *) sort:(int(^)(id, id))block;
-(NSString *) join;
-(NSString *) join:(NSString *)separator;
-(NSArray *) take:(int)number;
-(NSArray *) step:(int)number;
-(BOOL) all:(BOOL(^)(id))block;
-(BOOL) none:(BOOL(^)(id))block;
-(BOOL) any:(BOOL(^)(id))block;
-(id) first;
-(id) last;
@end
