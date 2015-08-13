//
//  CadastradosTableViewController.h
//  SQLite
//
//  Created by Guilherme on 06/12/14.
//  Copyright (c) 2014 BoomerangApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CadastradosTableViewController : UITableViewController

@property(nonatomic, strong)NSArray *arrayCadastros;
@property(nonatomic, strong)NSArray *arrayInvertido;
@property(nonatomic, strong)UIRefreshControl *atualizador;

@end
