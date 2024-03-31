--Codigo_Cidade, Nome, Estado, Cep_Inicial , Cep_Final
-- Criar tabela CIDADES
CREATE TABLE CIDADES(
    Codigo_Cidade    INT NOT NULL IDENTITY PRIMARY KEY,
    Nome         VARCHAR(50),
    Estado       VARCHAR(25),
    Cep_Inicial  VARCHAR(8),
    Cep_Final    VARCHAR(8)
);


--Codigo_Cliente, CGC_CPF_Cliente, Nome, Telefone, Endereco, Bairro, Compelmento, E_mail,
--Codigo_Cidade (Relacionamento com Cidades), Cep (Validação do Cep conforme a cidade)

CREATE TABLE CLIENTES(
	Codigo_Cliente INT NOT NULL IDENTITY PRIMARY KEY,
	Nome            VARCHAR(150),
	CGC_CPF_Cliente VARCHAR(14),
	Telefone        VARCHAR(14),
	Endereco        VARCHAR(200),
	Bairro          VARCHAR(100),
	Complemento     VARCHAR(50),
	Cep             VARCHAR(8),
	Email           VARCHAR (100),
	Codigo_Cidade   INT,
	FOREIGN KEY (Codigo_Cidade) REFERENCES CIDADES(Codigo_Cidade)
);

