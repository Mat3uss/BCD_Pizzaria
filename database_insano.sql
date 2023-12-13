-- Criando e utilizando uma nova base de dados
create database pizzaria_insana_que_eu_fiz;

-- Excluindo a base de dados anterior, se existir
drop database pizzaria_insana_que_eu_fiz;

-- Selecionando a base de dados criada
use pizzaria_insana_que_eu_fiz;

-- Tabela de categorias
create table categoria
(
    categoria_id integer primary key auto_increment,
    nome varchar(50) not null
);

-- Tabela de produtos
create table produto
(
    produto_id integer primary key auto_increment,
    nome varchar(50) not null,
    preco double not null,
    descricao varchar(100),
    avaliacao double,
    quantidade_disponivel integer not null,
    categoria_id integer not null,
    
    foreign key (categoria_id) references categoria(categoria_id)
);

-- Tabela de imagens dos produtos
create table imagens_produtos
(
    imagens_produtos_id integer primary key auto_increment,
    url varchar(260) not null,
    id_produto integer not null,
    
    foreign key (id_produto) references produto(produto_id)
);

-- Tabela de endereços
create table endereco
(
    endereco_id integer primary key auto_increment,
    logradouro varchar(150) not null,
    cidade varchar(100) not null,
    cep bigint not null,
    uf varchar(2) not null
);

-- Tabela de usuários
create table usuario
(
    usuario_id integer primary key auto_increment,
    nome varchar(100) not null,
    telefone bigint,
    email varchar(70) not null,
    senha varchar(20) not null,
    cpf bigint not null,
    foto blob
);

-- Tabela de relacionamento entre usuário e endereço
create table usuario_endereco
(
    usuario_endereco_id integer primary key auto_increment,
    id_usuario integer not null,
    id_endereco integer not null,
    
    foreign key (id_endereco) references endereco(endereco_id),
    foreign key (id_usuario) references usuario(usuario_id)
);

-- Tabela de produtos favoritos dos usuários
create table produto_favorito
(
    produto_favorito_id integer primary key auto_increment,
    id_usuario integer not null,
    id_produto integer not null,
    
    foreign key (id_usuario) references usuario(usuario_id),
    foreign key (id_produto) references produto(produto_id)
);

-- Tabela de comentários
create table comentario
(
    comentario_id integer primary key auto_increment,
    id_usuario integer not null,
    id_produto integer not null,
    estrelas double,
    titulo varchar(50) not null,
    data_comentario date not null,
    comentario varchar(250),
    
    foreign key (id_usuario) references usuario(usuario_id),
    foreign key (id_produto) references produto(produto_id)
);

-- Tabela de pagamentos
create table pagamento
(
    pagamento_id integer primary key auto_increment,
    tipo varchar(50) not null,
    banco varchar(50),
    numero_cartao bigint,
    cvv integer,
    id_usuario integer not null,
    
    foreign key (id_usuario) references usuario(usuario_id)
);

-- Tabela de pedidos
create table pedido
(
    pedido_id integer primary key auto_increment,
    data_pedido date not null,
    frete double not null,
    total double not null,
    quantidade_itens integer not null,
    id_usuario_endereco integer not null,
    
    foreign key (id_usuario_endereco) references usuario_endereco(usuario_endereco_id)
);

-- Tabela de relacionamento entre pedido e produto
create table pedido_produto
(
    pedido_produto_id integer primary key auto_increment,
    id_pedido integer not null,
    id_produto integer not null,
    
    foreign key (id_produto) references produto(produto_id),
    foreign key (id_pedido) references pedido(pedido_id)
);

-- Tabela de informações de pagamento associadas aos pedidos
create table pagamento_info
(
    pagamento_info_id integer primary key auto_increment,
    id_pagamento integer not null,
    id_pedido integer not null,
    data_pagamento datetime not null,
    
    foreign key (id_pagamento) references pagamento(pagamento_id),
    foreign key (id_pedido) references pedido(pedido_id)
);
