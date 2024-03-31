object dm: Tdm
  Left = 0
  Top = 0
  Caption = 'dm'
  ClientHeight = 149
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=gustavo;Data Source=DESKTOP-EFUQVFS\SQL' +
      'EXPRESS'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 16
  end
  object ADOProc_cidades: TADOStoredProc
    Connection = ADOConnection1
    ProcedureName = 'pd_operacoes_cidades;1'
    Parameters = <
      item
        Name = '@opcao'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Codigo_Cidade'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Nome'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@Estado'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2
        Value = Null
      end
      item
        Name = '@Cep_Inicial'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
        Value = Null
      end
      item
        Name = '@Cep_Final'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
        Value = Null
      end
      item
        Name = '@ErrMsg'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 255
        Value = Null
      end>
    Prepared = True
    Left = 120
    Top = 16
  end
  object ADOqry_cidades: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT Codigo_Cidade, Nome, Estado, Cep_Inicial, Cep_Final '
      'FROM CIDADES;')
    Left = 32
    Top = 88
  end
  object ADOqry_clientes: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT       CL.Codigo_Cliente, '
      '                   CL.Nome, '
      '                   CL.CGC_CPF_Cliente, '
      #9'   CL.Telefone, '
      #9'   CL.Endereco,'
      '                   CL.Bairro,'
      #9'   CL.Complemento, '
      #9'   CL.Cep,'
      '                   CL.Email,'
      #9'   CID.Nome Cidade,'
      #9'   CID.Estado,'
      '        CL.Codigo_Cidade'
      'FROM CLIENTES CL '
      'INNER JOIN CIDADES CID '
      'ON CL.Codigo_Cidade = CID.Codigo_Cidade;'
      '')
    Left = 104
    Top = 88
    object ADOqry_clientesCodigo_Cliente: TAutoIncField
      FieldName = 'Codigo_Cliente'
      ReadOnly = True
    end
    object ADOqry_clientesNome: TStringField
      FieldName = 'Nome'
      Size = 150
    end
    object ADOqry_clientesCGC_CPF_Cliente: TStringField
      FieldName = 'CGC_CPF_Cliente'
      Size = 14
    end
    object ADOqry_clientesTelefone: TStringField
      FieldName = 'Telefone'
      Size = 14
    end
    object ADOqry_clientesEndereco: TStringField
      FieldName = 'Endereco'
      Size = 200
    end
    object ADOqry_clientesBairro: TStringField
      FieldName = 'Bairro'
      Size = 100
    end
    object ADOqry_clientesComplemento: TStringField
      FieldName = 'Complemento'
      Size = 50
    end
    object ADOqry_clientesCep: TStringField
      FieldName = 'Cep'
      Size = 8
    end
    object ADOqry_clientesEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object ADOqry_clientesCidade: TStringField
      FieldName = 'Cidade'
      Size = 50
    end
    object ADOqry_clientesEstado: TStringField
      FieldName = 'Estado'
      Size = 25
    end
    object ADOqry_clientesCodigo_Cidade: TIntegerField
      FieldName = 'Codigo_Cidade'
    end
  end
  object ADOProc_clientes: TADOStoredProc
    Connection = ADOConnection1
    ProcedureName = 'pd_operacoes_clientes;1'
    Parameters = <
      item
        Name = '@opcao'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Codigo_Cliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Nome'
        Attributes = [paNullable]
        DataType = ftString
        Size = 150
        Value = Null
      end
      item
        Name = '@CGC_CPF_Cliente'
        Attributes = [paNullable]
        DataType = ftString
        Size = 14
        Value = Null
      end
      item
        Name = '@Telefone'
        Attributes = [paNullable]
        DataType = ftString
        Size = 14
        Value = Null
      end
      item
        Name = '@Endereco'
        Attributes = [paNullable]
        DataType = ftString
        Size = 200
        Value = Null
      end
      item
        Name = '@Bairro'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Complemento'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@Cep'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
        Value = Null
      end
      item
        Name = '@Email'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Codigo_Cidade'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@ErrMsg'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 255
        Value = Null
      end>
    Prepared = True
    Left = 224
    Top = 16
  end
end
