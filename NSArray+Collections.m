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
	[self each:^(id object) {
		id mappedItem = block(object);
		[result addObject:mappedItem];
	}];
	return [NSArray arrayWithArray:result];
}

-(NSArray *) select: (bool(^)(id object))block {
	NSMutableArray *result = [NSMutableArray array];
	[self each:^(id object) {
		if(block(object)){
			[result addObject:object];
		};
	}];
	return [NSArray arrayWithArray:result];
}

-(NSString *) join {
	return [self join:@""];
}

-(NSString *) join:(NSString *)separator {
	return [self componentsJoinedByString:separator];
}

-(NSArray *) filter: (bool(^)(id object))block {
	return [self select:block];
}

-(NSArray *) sort: (int(^)(id obj1, id obj2))block {
	return [self sortedArrayUsingComparator:block];
}

-(id) first {
	return [self objectAtIndex:0];
}

-(id) last {
	return [self lastObject];
}

@end
