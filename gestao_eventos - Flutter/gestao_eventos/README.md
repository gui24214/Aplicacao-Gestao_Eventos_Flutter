# Gestão de Eventos (Flutter + API)

Projeto de gestão de eventos desenvolvido em equipa, integrando frontend, backend e base de dados.  
Permite criar, listar, editar e remover eventos, inscrever participantes, mostrar estatísticas e bilhetes.

## Trabalho em Equipa
- Guilherme: Desenvolvimento da aplicação Flutter
- Daniela: Base de dados em SQL Server
- Bárbara: API em C# (.NET)
- Renata: Design do cartaz

## Tecnologias
- Flutter (Dart)
- C# (.NET) para API utilizando HTTP
- SQL Server para base de dados
- VS Code (Flutter)
- Visual Studio 2022 (API C#)

## Funcionalidades
- Criar evento (nome, data, local)
- Listar todos os eventos
- Editar evento existente
- Remover evento
- Inscrever participante em evento
- Remover participante de evento
- Mostrar estatísticas da aplicação
- Mostrar bilhetes

## Estrutura do projeto

eventos-flutter/
├── app_flutter/ # código da aplicação Flutter
├── api_csharp/ # código da API em C#
├── database/ # scripts SQL para criar a base de dados
└── docs/ # imagens, diagramas, cartaz, prints

## Como executar

### Pré-requisitos
- SQL Server com a base de dados criada e ligada
- Visual Studio 2022 (para API C#)
- VS Code e Flutter SDK (para a aplicação Flutter)

### API C#
1. Abrir o projeto `api_csharp` no Visual Studio 2022
2. Restaurar pacotes NuGet
3. Certificar-se que a string de ligação (`connection string`) aponta para a base de dados correta
4. Executar a API (por padrão via HTTP, ex.: `http://localhost:5000`)

### Aplicação Flutter
1. Abrir o projeto `app_flutter` no VS Code
2. Instalar dependências:
3. ```bash
flutter pub get

A aplicação comunica com a API via HTTP e necessita que a API esteja a correr e a base de dados esteja ligada.

##Base de dados

Criar a base de dados no SQL Server usando os scripts da pasta database/
Certificar-se que a API tem a ligação correcta à base de dados

Autor
Trabalho em equipa — Guilherme (Flutter), Daniela (Base de dados), Bárbara (API), Renata (Design)
Porém todo o grupo ajudou nas outras partes do projeto 
