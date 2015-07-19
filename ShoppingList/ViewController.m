//
//  ViewController.m
//  ShoppingList
//
//  Created by John Tan on 19/7/15.
//  Copyright (c) 2015 John Tan. All rights reserved.
//

#import "ViewController.h"
#import "List.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *shopList;
@property NSMutableArray *shoppingList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"List" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    self.shoppingList = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    
}
- (IBAction)onSaveButtonPressed:(UIButton *)sender {
    //self.shoppingList = [NSArray arrayWithArray: self.shopList.text];
    
//    
//    for (NSMutableArray *eachArray in self.shoppingList) {
       NSManagedObject *shopList = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:self.managedObjectContext];
        // This how you get a reference to the entity so that you can fill details to the entity and add to the managedObjectContext
       
        [shopList setValue: self.shopList.text forKey:@"name"];
        
        
        [self.managedObjectContext save:nil];
    [self.shoppingList addObject: shopList];
    [self.tableView reloadData];
    
    }



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shoppingList.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath: indexPath]; //MyCell is the name of the Table Cell i entered in the story board
    NSManagedObject *fetchedObject = [self.shoppingList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [fetchedObject valueForKey:@"name"];
//    cell.detailTextLabel.text = [tempDictionary objectForKey:@"actor"];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
