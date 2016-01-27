//
//  RootTableViewController.m
//  GameOfThrones
//
//  Created by Nicholas Naudé on 26/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "RootTableViewController.h"
#import "Character.h"
#import "AppDelegate.h"
#import "AddCharacterViewController.h"

@interface RootTableViewController ()

@property NSMutableArray *characterArray;

@property NSArray *data;

@property NSManagedObjectContext *moc;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.characterArray = [NSMutableArray new];
    
    self.data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"gameofthrones" ofType:@"plist"]];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
    self.moc = appDelegate.managedObjectContext;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [self loadCharacters];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.characterArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    Character *character = [self.characterArray objectAtIndex:indexPath.row];
    cell.textLabel.text = character.name;
    
    return cell;
}

- (void) loadCharacters{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: @"Character"];
    
//    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES];
//    
//    NSSortDescriptor *sortByAge = [[NSSortDescriptor alloc] initWithKey: @"age" ascending: YES];
//    
//    request.sortDescriptors = @[sortByName, sortByAge];
//    
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age < %@", self.age];
//        request.predicate = predicate;
    
    NSError *error;
    self.characterArray = [[self.moc executeFetchRequest:request error:&error]mutableCopy];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
}

@end
