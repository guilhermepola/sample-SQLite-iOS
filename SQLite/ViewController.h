//
//  ViewController.h
//  SQLite
//
//  Created by Guilherme on 06/12/14.
//  Copyright (c) 2014 BoomerangApps. All rights reserved.
//

#import <UIKit/UIKit.h>
//importando o SQLite
#import <sqlite3.h>
@interface ViewController : UIViewController{
//Criar a referencia para Banco de dados
    sqlite3 *meuBanco;
    
    //iVar que representa os comandos SQL
    char *comando;
  

}

//@property(nonatomic, assign)sqlite3 *meubanco;
//@property(nonatomic, assign)char *comando;

@property (weak, nonatomic) IBOutlet UITextField *textFieldNome;
@property (weak, nonatomic) IBOutlet UITextField *textFieldIdade;
@property(nonatomic, strong)NSMutableArray *arrayCadastros;

- (IBAction)salvar:(UIButton *)sender;
- (IBAction)resgatar:(UIButton *)sender;


@end

