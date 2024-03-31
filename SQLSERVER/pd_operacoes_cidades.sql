DROP PROCEDURE IF EXISTS pd_operacoes_cidades
GO

CREATE PROCEDURE pd_operacoes_cidades
    @opcao         INT,
	@Codigo_Cidade INT,
    @Nome          VARCHAR(50),
    @Estado        VARCHAR(2),
    @Cep_Inicial   VARCHAR(8),
    @Cep_Final     VARCHAR(8),
	@ErrMsg        VARCHAR(255) OUTPUT
AS
BEGIN
  -- @opcao = 1 -- Cadastrar Cidade
  -- @opcao = 2 -- Alterar Cidade
  -- @opcao = 3 -- Excluir Cidade
 
-- Cadastrando Cidade --
 IF @opcao = 1
 BEGIN
	-- Caso a Cidade n�o exista ela � cadastrada --
	IF NOT EXISTS (SELECT 1 FROM CIDADES WHERE Nome = @Nome)
	BEGIN
      INSERT INTO cidades(Nome, Estado, Cep_Inicial, Cep_Final)
	  VALUES(@Nome, @Estado, @Cep_Inicial, @Cep_Final);
	  SET @ErrMsg = ''
	END
	ELSE
	-- Caso ela exista o erro � exibido --
	BEGIN
	  SET @ErrMsg = 'Cidade j� cadastrada!'
	  RETURN
	END	
  END
  -- Editando Cidade --
  IF @opcao = 2
  BEGIN 
	UPDATE cidades 
	SET Nome = @Nome, Estado = @Estado, Cep_Inicial = @Cep_Inicial, Cep_Final = @Cep_Final
	WHERE Codigo_Cidade = @Codigo_Cidade;
	SET @ErrMsg = 'Cidade atualizada com sucesso!'
  END
  -- Exluindo Cidade --
  IF @opcao = 3
  BEGIN
	IF EXISTS (SELECT CLI.Codigo_Cidade FROM CLIENTES CLI
                   INNER JOIN CIDADES CID ON
                   CLI.Codigo_Cidade = CID.Codigo_Cidade)
	BEGIN
      DELETE FROM cidades
   	  WHERE Codigo_Cidade = @Codigo_Cidade;
	  SET @ErrMsg = ''
	END
	ELSE
	BEGIN
	  SET @ErrMsg = 'N�o � poss�vel deletar pois h� clientes cadastrados com essa cidade!'
	END
  END

END;
