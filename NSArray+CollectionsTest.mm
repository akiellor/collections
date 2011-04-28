#import <SenTestingKit/SenTestingKit.h>
#import "NSArray+Collections.h"

#define HC_SHORTHAND

#import <OCHamcrest/OCHamcrest.h>

@interface NSArray_CollectionsTest : SenTestCase
@end

@implementation NSArray_CollectionsTest

- (void) testEachReturn {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array each:^(id item) { }];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) testEach {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	NSMutableArray *actual = [NSMutableArray array];
	
	[array each:^(id item) {
		[actual addObject:item];
	}];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) testMap {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array map:^(id item) {
		return [NSString stringWithFormat:@"WOOT %@", item];
	}];
	
    assertThat(actual, contains(@"WOOT 1", @"WOOT 2", @"WOOT 3", @"WOOT 4", @"WOOT 5", nil));
}

- (void) testSelect {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array select:^(id item) {
		return item == @"1";
	}];
	
    assertThat(actual, contains(@"1", nil));
}

- (void) testFilter {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array filter:^(id item) {
		return item == @"1";
	}];
	
    assertThat(actual, contains(@"1", nil));
}

@end
