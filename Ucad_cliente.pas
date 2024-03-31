unit Ucad_cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.DBCtrls, Vcl.Mask;

type
  TFcad_cliente = class(TForm)
    pnl_cad_cli: TPanel;
    edt_nome: TEdit;
    edt_bairro: TEdit;
    edt_complemento: TEdit;
    edt_endereco: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    edt_email: TEdit;
    Image9: TImage;
    pnl_gravar: TPanel;
    btn_gravar: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DScidades: TDataSource;
    DSclientes: TDataSource;
    cb_cidades: TDBLookupComboBox;
    edt_cpf: TMaskEdit;
    edt_telefone: TMaskEdit;
    edt_cep: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    estado : integer;
  end;

var
  Fcad_cliente: TFcad_cliente;

implementation

{$R *.dfm}

uses Udm, Ulista_clientes;

procedure MakeRounded(Control: TWinControl);
//Procedure para arredondar os componentes
var
R: TRect;
Rgn: HRGN;
begin
with Control do
  begin
    R := ClientRect;
   rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
    Perform(EM_GETRECT, 0, lParam(@r));
   InflateRect(r, - 5, - 5);
    Perform(EM_SETRECTNP, 0, lParam(@r));
    SetWindowRgn(Handle, rgn, True);
  end;
end;

procedure TFcad_cliente.FormClose(Sender: TObject; var Action: TCloseAction);
//Quando o Form é fechado libera memória
begin
  Free;
end;

procedure TFcad_cliente.FormCreate(Sender: TObject);
//Arredonda os componentes
begin
  Makerounded(edt_nome);
  Makerounded(edt_cpf);
  Makerounded(edt_telefone);
  Makerounded(edt_endereco);
  Makerounded(edt_bairro);
  Makerounded(edt_complemento);
  Makerounded(cb_cidades);
  Makerounded(edt_cep);
  Makerounded(edt_email);
  Makerounded(pnl_gravar);
end;

procedure TFcad_cliente.FormShow(Sender: TObject);
//Quando o Fomr é exibido
begin
  DScidades.DataSet.Close;
  DScidades.DataSet.Open;

  if estado = 1 then
  begin
    edt_nome.Text        := '';
    edt_cpf.Text         := '';
    edt_telefone.Text    := '';
    edt_endereco.Text    := '';
    edt_bairro.Text      := '';
    edt_complemento.Text := '';
    edt_cep.Text         := '';
    edt_email.Text       := '';
    cb_cidades.KeyValue  := null;
  end
  else
  begin
    pnl_cad_cli.Caption := 'EDITAR - CLIENTE';
    edt_nome.Text        := DSclientes.DataSet.FieldByName('Nome').AsString;
    edt_cpf.Text         := DSclientes.DataSet.FieldByName('CGC_CPF_Cliente').AsString;
    edt_telefone.Text    := DSclientes.DataSet.FieldByName('Telefone').AsString;
    edt_endereco.Text    := DSclientes.DataSet.FieldByName('Endereco').AsString;
    edt_bairro.Text      := DSclientes.DataSet.FieldByName('Bairro').AsString;
    edt_complemento.Text := DSclientes.DataSet.FieldByName('Complemento').AsString;
    edt_cep.Text         := DSclientes.DataSet.FieldByName('Cep').AsString;
    edt_email.Text       := DSclientes.DataSet.FieldByName('Email').AsString;
    cb_cidades.KeyValue  := DSclientes.DataSet.FieldByName('Codigo_Cidade').AsInteger;
    edt_cpf.ReadOnly := True;
  end;
end;

procedure TFcad_cliente.btn_gravarClick(Sender: TObject);
//Botão GRAVAR
begin
  if estado = 1 then
  begin
    dm.ADOProc_clientes.Close;
    dm.ADOProc_clientes.Parameters.ParamByName('@opcao').Value            := 1;
    dm.ADOProc_clientes.Parameters.ParamByName('@Nome').Value             := edt_nome.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@CGC_CPF_Cliente').Value  := edt_cpf.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Telefone').Value         := edt_telefone.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Endereco').Value         := edt_endereco.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Bairro').Value           := edt_bairro.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Complemento').Value      := edt_complemento.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Cep').Value              := edt_cep.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Email').Value            := edt_email.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Codigo_Cidade').Value    := cb_cidades.KeyValue;
    dm.ADOProc_clientes.ExecProc;

    if dm.ADOProc_clientes.Parameters.ParamByName('@ErrMsg').Value <> '' then
    begin
      ShowMessage(dm.ADOProc_clientes.Parameters.ParamByName('@ErrMsg').Value)
    end
    else
    begin
      Application.MessageBox('Cliente Cadastrado!','Aviso',MB_OK);
      Close;
    end;
  end
  else
  begin
    dm.ADOProc_clientes.Close;
    dm.ADOProc_clientes.Parameters.ParamByName('@opcao').Value            := 2;
    dm.ADOProc_clientes.Parameters.ParamByName('@Nome').Value             := edt_nome.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@CGC_CPF_Cliente').Value  := edt_cpf.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Telefone').Value         := edt_telefone.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Endereco').Value         := edt_endereco.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Bairro').Value           := edt_bairro.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Complemento').Value      := edt_complemento.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Cep').Value              := edt_cep.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Email').Value            := edt_email.Text;
    dm.ADOProc_clientes.Parameters.ParamByName('@Codigo_Cidade').Value    := cb_cidades.KeyValue;
    dm.ADOProc_clientes.ExecProc;
    Application.MessageBox('Cadastro de Cliente Alterado!','Sucesso!');
    Close;
    Flista_clientes.atualiza_clientes;
  end;
end;

end.
