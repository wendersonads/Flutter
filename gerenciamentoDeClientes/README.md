<h2>Sistema de Gerenciamento Clientes</h2>

<h3> Requisitos para rodar o projeto</h3>

<li><b>Flutter SDK <= 3.3.10:</b> Devido algumas bibliotecas utilizadas no projeto não funciona em todas as versões "Na minha máquina estou usando 3.3.10".
<li><b>Java JDK</b> A Api está feita em Java com SpringBoot Framework então há a necessidade de ter o JAVA JDK instalado Download disponnivel em => https://www.oracle.com/br/java/technologies/downloads/#java17 

<h3> Rodando API</h3>

<p>
   Na pasta api/src/java executar a classe AuthenticationApiApplication.java como está mostrando no imagem abaixo:
</p>

<div align="center">
    <img src="utilitarios/ClasseJava.png" alt="Classe Java" />
</div>

<h3> Conectando ao Banco Servidor rodando na AWS</h3>

<p>
   Para conectar ao banco de dados pode ser utilizado qualquer programa que abra o Postgres, no exemplo abaixo estou usando o próprio VsCode com a extensão MySQL:
</p>

<div align="center">
    <img src="utilitarios/Config.png" alt="Classe Java" />
</div>

<h3> Dados do servidor</h3>

<p>Host: 54.207.164.209</p>
<p>Username: postgres</p>
<p>Database: postgres</p>
<p>Port: 5433</p>
<p>Password: j8s4684298ds74</p>

<h3> Perfil Administrativo</h3>

<p>
    Ao realizar um novo cadastro no Sistema o novo usuário ficará sem perfil vinculado, pode se acessar o sistema com perfil de admin e conceder acesso ao sistema como está mostrando abaixo, ou continuar com perfil de admin e executar o CRUD. 
</p>
<p>
    Obs: Nos dois perfis o Crud está disponível, o perfil admin contém uma funcionalidade a mais de vincular perfil
</p>
<p>
    Perfil criado para processo seletivo: Cad. Cliente
</p>
<p>
     Usuario Admin: admin
</p>
<p>
     Senha: admin
</p>

<div align="center" style="display: flex; justify-content: space-around;">
    <img src="utilitarios/MenuUser.png" alt="Classe Java" />
    <img src="utilitarios/TelaPerfil.png" alt="Classe Java" />
</div>

<h3>Iniciando Aplicativo</h3>

<p>
     Devido algumas configurações do projeto, no momento so está rodando na Web então deve ser selecionado no Vscode a plataforma Web conforme está na Imagem abaixo:
</p>

<div align="center" >
    <img src="utilitarios/vsCode.png" alt="Classe Java" />
</div>

<p>
    Para configuração do projeto está sendo utilizado o Hive para gerenciar e armanezar token, e acesso de funcionalidades do sistema por perfil de acesso. O hive_flutter é um pacote do Flutter que fornece uma solução de armazenamento de dados rápida e fácil de usar baseada no banco de dados Hive. Ele é útil quando você precisa armazenar dados de forma persistente e acessa-los rapidamente em seu aplicativo Flutter. Por esse motivo o inicialização do sistema está não está carregando de forma automática por enquanto, sendo necessário fazer Restart no VsCode clicando no botão de restart conforme mostra a imagem abaixo:
</p>

div align="center" style="display: flex; justify-content: space-around;">
    <img src="utilitarios/telaHive.png" alt="Classe Java" />
    <img src="utilitarios/restarVsCode.png" alt="Classe Java" />
</div>
