unit Ulista_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TFlista_clientes = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    pnl_editar: TPanel;
    pnl_excluir: TPanel;
    btn_excluir: TSpeedButton;
    btn_editar: TSpeedButton;
    DSclientes: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure atualiza_clientes;
  end;

var
  Flista_clientes: TFlista_clientes;

implementation

{$R *.dfm}

uses Udm, Ucad_cliente;

procedure MakeRounded(Control: TWinControl);
// Procedure para arredondar os componentes
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
  end;
end;

procedure TFlista_clientes.btn_editarClick(Sender: TObject);
//Botão EDITAR
begin
  Application.CreateForm(TFcad_cliente, Fcad_cliente);
  Fcad_cliente.estado := 2;
  Fcad_cliente.Show;
end;

procedure TFlista_clientes.btn_excluirClick(Sender: TObject);
//Botão EXCLUIR
var
  CPF: string;
begin
  if Application.MessageBox('Deseja realmente excluir o cliente?', 'Aviso!',
    MB_ICONQUESTION + MB_YESNO) = mrYes then
  begin
    CPF := DSclientes.DataSet.FieldByName('CGC_CPF_Cliente').AsString;
    dm.ADOProc_clientes.Close;
    dm.ADOProc_clientes.Parameters.ParamByName('@opcao').Value := 3;
    dm.ADOProc_clientes.Parameters.ParamByName('@CGC_CPF_Cliente').Value := CPF;
    dm.ADOProc_clientes.ExecProc;

    if dm.ADOProc_clientes.Parameters.ParamByName('@ErrMsg').Value <> '' then
    begin
      Application.MessageBox('Erro ao deletar Cliente', 'Erro', MB_OK);
    end
    else
    begin
      Application.MessageBox('Cliente Deletado!', 'Aviso', MB_OK);
    end;

    DSclientes.DataSet.Close;
    DSclientes.DataSet.Open;
  end
  else
  begin
    exit;
  end;
end;

procedure TFlista_clientes.DBGrid1DblClick(Sender: TObject);
//Duplo clique no grid
begin
  Application.CreateForm(TFcad_cliente, Fcad_cliente);
  Fcad_cliente.Show;
end;

procedure TFlista_clientes.FormClose(Sender: TObject; var Action: TCloseAction);
//Quando o Form é fechado libera memória
begin
  Free;
end;

procedure TFlista_clientes.FormCreate(Sender: TObject);
//Arredonda os componentes
begin
  MakeRounded(pnl_editar);
  MakeRounded(pnl_excluir);
  DSclientes.DataSet.Close;
  DSclientes.DataSet.Open;
end;

procedure TFlista_clientes.atualiza_clientes;
//Atualiza a lista de Clientes
begin
  DSclientes.DataSet.Close;
  DSclientes.DataSet.Open;
end;

end.
