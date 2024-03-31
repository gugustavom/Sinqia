DROP PROCEDURE IF EXISTS pd_operacoes_clientes
GO

CREATE PROCEDURE pd_operacoes_clientes
	@opcao           INT,
	@Codigo_Cliente  INT,
	@Nome            VARCHAR(150),
	@CGC_CPF_Cliente VARCHAR(14),
	@Telefone        VARCHAR(14),
	@Endereco        VARCHAR(200),
	@Bairro          VARCHAR(100),
	@Complemento     VARCHAR(50),
	@Cep             VARCHAR(8),
	@Email           VARCHAR (100),
	@Codigo_Cidade   INT,
	@ErrMsg        VARCHAR(255) OUTPUT

AS
BEGIN
  -- Declaração das variaveis @CEP_Inicial e @CEP_Final --
  -- Para verificar se o CEP está correto no cadastro do cliente --
  DECLARE @CEP_Inicial VARCHAR(8);
  DECLARE @CEP_Final   VARCHAR(8);

  -- @opcao = 1 -- Cadastrar Cliente
  -- @opcao = 2 -- Alterar Cliente
  -- @opcao = 3 -- Excluir Cliente

  -- Cadastrando Cliente --
  IF @opcao = 1
  BEGIN
  -- Caso o Cliente não exista ela é cadastrada --
	IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE CGC_CPF_Cliente = @CGC_CPF_Cliente)
	BEGIN
	  -- Resgatando o CEP Inicial e o CEP Final da cidade escolhida --
	  SELECT @CEP_Inicial = Cep_Inicial,
	         @CEP_Final   = Cep_Final
	  FROM CIDADES
	  WHERE Codigo_Cidade = @Codigo_Cidade

	  -- Verificando se a cidade que o cliente escolheu esta com CEP correto --
	  IF @Cep BETWEEN @CEP_Inicial AND @CEP_Final 
	  BEGIN
	    INSERT INTO clientes(Nome, CGC_CPF_Cliente, Telefone, Endereco, Bairro, Complemento, Cep, Email, Codigo_Cidade)
	    VALUES(@Nome, @CGC_CPF_Cliente, @Telefone, @Endereco, @Bairro, @Complemento, @Cep, @Email, @Codigo_Cidade);
	    SET @ErrMsg = ''
	  END
	  ELSE
	  BEGIN
	    SET @ErrMsg = 'CEP Inválido'
		RETURN
	  END
	END
	ELSE
	-- Caso o Cliente já esteja cadastrado a mensagem é exibida --
	BEGIN
	  SET @ErrMsg = 'Cliente já cadastrado(a)!'
	  RETURN
	END	
  END

  -- Editando Cliente --
  IF @opcao = 2
  BEGIN
	UPDATE CLIENTES 
	SET Nome = @Nome, CGC_CPF_Cliente = @CGC_CPF_Cliente, Telefone = @Telefone, Endereco = @Endereco, 
	Bairro = @Bairro, Complemento = @Complemento, Cep = @Cep, Email = @Email, Codigo_Cidade = @Codigo_Cidade
	WHERE CGC_CPF_Cliente = @CGC_CPF_Cliente;
  END

  -- Excluindo Cliente --
  IF @opcao = 3
  BEGIN 
    DELETE FROM CLIENTES
	WHERE CGC_CPF_Cliente = @CGC_CPF_Cliente;
	SET @ErrMsg = ''
  END

END;

