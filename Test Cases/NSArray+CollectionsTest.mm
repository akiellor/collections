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
		return (BOOL)(item == @"1");
	}];
	
    assertThat(actual, contains(@"1", nil));
}

- (void) testFilter {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array filter:^(id item) {
		return [item isEqual:@"1"];
	}];
	
    assertThat(actual, contains(@"1", nil));
}

- (void) testSort {
    NSArray *array = [NSArray arrayWithObjects:@"4", @"2", @"3", @"1", @"5", nil ];
	
	NSArray *actual = [array sort:^(id obj1, id obj2) {
        return [obj1 localizedCaseInsensitiveCompare:obj2];		
	}];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) testFirst {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	id actual = [array first];
	
    assertThat(actual, is(@"1"));
}

- (void) testLast {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	id actual = [array last];
	
    assertThat(actual, is(@"5"));
}

- (void) testJoin {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array join];
	
    assertThat(actual, is(@"12345"));
}

- (void) testJoinWithSeparator {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array join:@","];
	
    assertThat(actual, is(@"1,2,3,4,5"));
}

- (void) testMapAndLast {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	id actual = [[array map:^(id object) { return [NSString stringWithFormat:@"WOOT %@", object]; }] last];
	
    assertThat(actual, is(@"WOOT 5"));
}

- (void) testTake {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array take:2];
	
    assertThat(actual, contains(@"1", @"2", nil));
}

- (void) testTakeZero {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array take:0];
	
    assertThat(actual, is(empty()));
}

- (void) testTakeLength {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array take:5];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) testStep {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array step:2];
	
    assertThat(actual, contains(@"3", @"4", @"5", 
								nil));
}

- (void) testStepZero {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array step:0];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) testStepLength {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array step:5];
	
    assertThat(actual, is(empty()));
}

- (void) testStepTake {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [[array step:1] take:2];
	
    assertThat(actual, contains(@"2", @"3", nil));
}

- (void) testAllWhenValuesYesYieldYes {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array all:^(id object) { return YES; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) testAllWhenSomeValuesNoYieldNo {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array all:^(id object) { return [object isEqual:@"1"]; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) testAllWhenValuesNoYieldNo {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array all:^(id object) { return NO; }];
	
    assertThatBool(actual, equalToBool(NO));
}


- (void) testNoneWhenValuesYesYieldNo {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array none:^(id object) { return YES; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) testNoneWhenSomeValuesYesYieldNo {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array none:^(id object) { return [object isEqual:@"1"]; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) testNoneWhenValuesNoYieldNo {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array none:^(id object) { return NO; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) testAnyWhenValuesYesYieldYes {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array any:^(id object) { return YES; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) testAnyWhenSomeValuesYesYieldYes {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array any:^(id object) { return [object isEqual:@"1"]; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) testAnyWhenValuesNoYieldNo {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array any:^(id object) { return NO; }];
	
    assertThatBool(actual, equalToBool(NO));
}
@end
