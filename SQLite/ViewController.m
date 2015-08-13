//
//  ViewController.m
//  SQLite
//
//  Created by Guilherme on 06/12/14.
//  Copyright (c) 2014 BoomerangApps. All rights reserved.
//

#import "ViewController.h"
#import "CadastradosTableViewController.h"

#define HOME NSHomeDirectory()
#define DOCUMENTS [HOME stringByAppendingPathComponent:@"Documents"]
#define CAMINHO_ARQUIVO [DOCUMENTS stringByAppendingPathComponent:@"cadastros.sqlite"]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Fazer o btn voltar no código
  self.navigationItem.backBarButtonItem.title = @"WOLOLOOO";
    
    NSLog(@"%@", DOCUMENTS);
    //Criando um gerenciador de arquivos
    NSFileManager *gerenciadorDeArquivos = [NSFileManager defaultManager];
    //Verificando se o arquivo existe
    if ([gerenciadorDeArquivos fileExistsAtPath:CAMINHO_ARQUIVO]) {
        
        
        //Caso exista o arquivo, abrimos ele
        sqlite3_open([CAMINHO_ARQUIVO UTF8String], &meuBanco);
        
    }else{
    
        //Caso o banco não exista, criamos ele (que é o mesma função para abrir)
        sqlite3_open([CAMINHO_ARQUIVO UTF8String], &meuBanco);
        
        //Montando o comando que cria a tabela com os campos que precisamos
        comando = "create table if not exists ALUNOS (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, nome TEXT, idade INTEGER)";
        
        //Comando que executa algumas
        sqlite3_exec(meuBanco, comando, NULL, 0, NULL);
        
    
    }
    
    

}
//viewDidAppear - sempre que a view for carregada
-(void)viewDidAppear:(BOOL)animated{

    self.arrayCadastros = [[NSMutableArray alloc]init];
//    [self.arrayCadastros removeAllObjects];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)salvar:(UIButton *)sender {
    //Verificando se o usuário inseriu alguma informação nos campos
    if (self.textFieldIdade.text.length > 0 && self.textFieldNome.text.length > 0) {
        
        //Criando um NSStringo com o comando para inserir na tabela ALUNOS
        NSString *stringComando =
        [NSString stringWithFormat:@"insert into ALUNOS values (NULL,'%@', %i)",
         self.textFieldNome.text,
         [self.textFieldIdade.text intValue]];
        
        //Executando o nosso comando SQL
        sqlite3_exec(meuBanco, [stringComando UTF8String], NULL, 0, NULL);
        
        //Verificar quando acontece algum erro
//        NSLog(@"%s", sqlite3_errmsg(meuBanco));
        
        //Limpando os campos
        self.textFieldIdade.text = nil;
        self.textFieldNome.text = nil;
        
        [self becomeFirstResponder];
        
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Alerta!"
                                            message:@"Dados salvos com sucesso"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alerta show];
        
    }else{
    
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Aviso!" message:@"Favor preencher os campos" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alerta show];
    
    }
    
    
    
}

- (IBAction)resgatar:(UIButton *)sender {
    
    //Comando que retorna todos os dados da tabela Aluno
    comando = "select * from ALUNOS";
    
    //Variável para armazenar o valor gerado pelo select
    sqlite3_stmt *resultado;
    
    //Função para resgatar os dados
    sqlite3_prepare_v2(meuBanco, comando, -1, &resultado, NULL);
    
    //Laço para percorrer todos os registros da tabela
    while (sqlite3_step(resultado) == SQLITE_ROW) {
        
        
        //Resgatando o valor do código
        int codigo = sqlite3_column_int(resultado, 0);
        
        //Resgatando o valor de nome
        NSString *nome = [NSString stringWithFormat:@"%s", sqlite3_column_text(resultado, 1)];
        
        //Resgatando o valor da idade
        int idade = sqlite3_column_int(resultado, 2);
        
        
        NSDictionary *dicionario = @{@"codigo": [NSNumber numberWithInt:codigo],
                                     @"nome": nome,
                                     @"idade": [NSNumber numberWithInt:idade]};
        
        NSLog(@"DICIONARIO: %@", dicionario);
        [self.arrayCadastros addObject:dicionario];
        
    }
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"irNovaTela"]) {
        
        CadastradosTableViewController *telaCadastrados = segue.destinationViewController;
        
        telaCadastrados.arrayCadastros = self.arrayCadastros;
        
        
        
        
    }

}


-(BOOL)canBecomeFirstResponder{

    return YES;

}




@end
