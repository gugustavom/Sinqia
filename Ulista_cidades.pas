unit Ulista_cidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TFlista_cidades = class(TForm)
    DBGrid1: TDBGrid;
    pnl_botoes: TPanel;
    pnl_excluir: TPanel;
    pnl_editar: TPanel;
    btn_editar: TSpeedButton;
    btn_excluir: TSpeedButton;
    DScidades: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    { Private declarations }
      public
    { Public declarations }
    procedure atualiza_cidades;
    end;

  var
    Flista_cidades: TFlista_cidades;

implementation

{$R *.dfm}

uses Udm, Ucad_cidade;

procedure MakeRounded(Control: TWinControl);
//Procedure que Arredonda os Componentes
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

procedure TFlista_cidades.btn_excluirClick(Sender: TObject);
//Botão EXCLUIR cidade
var
  cod_cidade: integer;
begin
  if Application.MessageBox('Deseja realmente excluir o cadastro?', 'Aviso!',
    MB_ICONQUESTION + MB_YESNO) = mrYes then
  begin
    cod_cidade := DScidades.DataSet.FieldByName('Codigo_Cidade').AsInteger;
    dm.ADOProc_cidades.Close;
    dm.ADOProc_cidades.Parameters.ParamByName('@opcao').Value := 3;
    dm.ADOProc_cidades.Parameters.ParamByName('@Codigo_Cidade').Value := cod_cidade;
    dm.ADOProc_cidades.ExecProc;

    if dm.ADOProc_cidades.Parameters.ParamByName('@ErrMsg').Value <> '' then
    begin
      Application.MessageBox('Não é possível deletar pois há clientes cadastrados com essa cidade!', 'Erro', MB_OK);
    end
    else
    begin
      Application.MessageBox('Cidade Deletada!', 'Aviso', MB_OK);
    end;

    DScidades.DataSet.Close;
    DScidades.DataSet.Open;
  end
  else
  begin
    exit;
  end;
end;

procedure TFlista_cidades.DBGrid1DblClick(Sender: TObject);
//Duplo clique no grid
begin
  Application.CreateForm(TFcad_cidade, Fcad_cidade);
  Fcad_cidade.Show;
end;

procedure TFlista_cidades.FormClose(Sender: TObject; var Action: TCloseAction);
//Quando o Form é fechado libera memória
begin
  Free;
end;

procedure TFlista_cidades.FormCreate(Sender: TObject);
//Arredonda os componentes
begin
  MakeRounded(pnl_editar);
  MakeRounded(pnl_excluir);
  dsCidades.DataSet.Close;
  dsCidades.DataSet.Open;
end;

procedure TFlista_cidades.btn_editarClick(Sender: TObject);
//Botão EDITAR
begin
  Application.CreateForm(TFcad_cidade, Fcad_cidade);
  Fcad_cidade.estado := 2;
  Fcad_cidade.Show;
end;

procedure TFlista_cidades.atualiza_cidades;
// Atualiza a Lista de Cidades
begin
  DScidades.DataSet.Close;
  DScidades.DataSet.Open;
end;

end.
