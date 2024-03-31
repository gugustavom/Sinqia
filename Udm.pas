unit Udm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB;

type
  Tdm = class(TForm)
    ADOConnection1: TADOConnection;
    ADOProc_cidades: TADOStoredProc;
    ADOqry_cidades: TADOQuery;
    ADOqry_clientes: TADOQuery;
    ADOProc_clientes: TADOStoredProc;
    ADOqry_clientesCodigo_Cliente: TAutoIncField;
    ADOqry_clientesNome: TStringField;
    ADOqry_clientesCGC_CPF_Cliente: TStringField;
    ADOqry_clientesTelefone: TStringField;
    ADOqry_clientesEndereco: TStringField;
    ADOqry_clientesBairro: TStringField;
    ADOqry_clientesComplemento: TStringField;
    ADOqry_clientesCep: TStringField;
    ADOqry_clientesEmail: TStringField;
    ADOqry_clientesCidade: TStringField;
    ADOqry_clientesEstado: TStringField;
    ADOqry_clientesCodigo_Cidade: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
