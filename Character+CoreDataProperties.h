//
//  Character+CoreDataProperties.h
//  GameOfThrones
//
//  Created by Nicholas Naudé on 26/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Character.h"

NS_ASSUME_NONNULL_BEGIN

@interface Character (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *actor;
@property (nullable, nonatomic, retain) NSString *house;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSData *picture;

@end

NS_ASSUME_NONNULL_END
