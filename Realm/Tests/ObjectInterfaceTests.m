////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMTestCase.h"

#pragma mark - Test Objects

#pragma mark - Tests

@interface ObjectInterfaceTests : RLMTestCase
@end

@implementation ObjectInterfaceTests

- (void)testCustomAccessorsObject
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    CustomAccessorsObject *ca = [CustomAccessorsObject createInRealm:realm withObject:@[@"name", @2]];
    XCTAssertEqualObjects([ca getThatName], @"name", @"name property should be name.");
    
    [ca setTheInt:99];
    XCTAssertEqual((int)ca.age, (int)99, @"age property should be 99");
    [realm commitWriteTransaction];
}

- (void)testCustomAccessorsWithObjectInit
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    CustomAccessorsObject *ca = [[CustomAccessorsObject alloc] init];
    ca.name = @"name";
    [realm addObject:ca];
    XCTAssertEqualObjects([ca getThatName], @"name", @"name property should be name.");
    
    [ca setTheInt:99];
    [realm commitWriteTransaction];
    
    CustomAccessorsObject *objectFromRealm = [CustomAccessorsObject allObjects][0];
    XCTAssertEqual((int)objectFromRealm.age, (int)99, @"age property should be 99");
}

- (void)testClassExtension
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    BaseClassStringObject *bObject = [[BaseClassStringObject alloc ] init];
    bObject.intCol = 1;
    bObject.stringCol = @"stringVal";
    [realm addObject:bObject];
    [realm commitWriteTransaction];
    
    BaseClassStringObject *objectFromRealm = [BaseClassStringObject allObjects][0];
    XCTAssertEqual(1, objectFromRealm.intCol, @"Should be 1");
    XCTAssertEqualObjects(@"stringVal", objectFromRealm.stringCol, @"Should be stringVal");
}

@end
