#import "NSArray+Collections.h"


@implementation NSArray (NSArray_Collections)
-(NSArray *) each: (void(^)(id object))block {
	for ( id item in self )
	{
		block(item);
	}
	return self;
}

-(NSArray *) map: (id(^)(id object))block {
	NSMutableArray *result = [NSMutableArray array];
	for ( id item in self )
	{
		id mappedItem = block(item);
		[result addObject:mappedItem];
	}
	return [NSArray arrayWithArray:result];
}

-(NSArray *) select: (bool(^)(id object))block {
	NSMutableArray *result = [NSMutableArray array];
	for ( id item in self )
	{
		if(block(item)){
			[result addObject:item];
		};
	}
	return [NSArray arrayWithArray:result];
}

-(NSArray *) filter: (bool(^)(id object))block {
	return [self select:block];
}
@end
