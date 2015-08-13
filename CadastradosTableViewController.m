//
//  CadastradosTableViewController.m
//  SQLite
//
//  Created by Guilherme on 06/12/14.
//  Copyright (c) 2014 BoomerangApps. All rights reserved.
//

#import "CadastradosTableViewController.h"

@interface CadastradosTableViewController ()

@end

@implementation CadastradosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.backBarButtonItem.title = @"WOLOLO";
    self.arrayInvertido = [[self.arrayCadastros reverseObjectEnumerator]allObjects];
    
    NSLog(@"Nossos dados: %@", self.arrayCadastros);
    
    self.atualizador = [[UIRefreshControl alloc]init];
    [self.atualizador addTarget:self
                         action:@selector(atualizar)
               forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.atualizador];
    
}

-(void)atualizar{
    [self.atualizador endRefreshing];

    [self.tableView reloadData];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrayCadastros.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celula"];
    

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celula"];
    }
    
    cell.textLabel.text = [[self.arrayInvertido objectAtIndex:indexPath.row]objectForKey:@"nome"];
    cell.detailTextLabel.text = [[[self.arrayInvertido objectAtIndex:indexPath.row]objectForKey:@"idade"]stringValue];
    
    
    return cell;
}
@end
