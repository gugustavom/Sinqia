unit Ucad_cidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Mask, Maskutils;

type
  TFcad_cidade = class(TForm)
    pnl_cad: TPanel;
    edt_nome: TEdit;
    cb_estado: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnl_gravar: TPanel;
    btn_gravar: TSpeedButton;
    DScidades: TDataSource;
    edt_cep_inicial: TMaskEdit;
    edt_cep_final: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    estado : integer;
  end;

var
  Fcad_cidade: TFcad_cidade;

implementation

{$R *.dfm}

uses Udm, Ulista_cidades;

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

procedure TFcad_cidade.btn_gravarClick(Sender: TObject);
//Bot�o de GRAVAR
begin
  if estado = 1 then
  begin
    dm.ADOProc_cidades.Close;
    dm.ADOProc_cidades.Parameters.ParamByName('@opcao').Value := 1;
    dm.ADOProc_cidades.Parameters.ParamByName('@Nome').Value := edt_nome.Text;
    dm.ADOProc_cidades.Parameters.ParamByName('@Estado').Value := cb_estado.Text;
    dm.ADOProc_cidades.Parameters.ParamByName('@Cep_Inicial').Value := edt_cep_inicial.Text;
    dm.ADOProc_cidades.Parameters.ParamByName('@Cep_Final').Value := edt_cep_final.Text;
    dm.ADOProc_cidades.ExecProc;

    if dm.ADOProc_cidades.Parameters.ParamByName('@ErrMsg').Value <> '' then
    begin
      ShowMessage(dm.ADOProc_cidades.Parameters.ParamByName('@ErrMsg').Value)
    end
    else
    begin
      Application.MessageBox('Cidade Cadastrada com Sucesso!','Aviso',MB_OK);
      Close;
    end;
  end
  else
  begin
    dm.ADOProc_cidades.Close;
    dm.ADOProc_cidades.Parameters.ParamByName('@opcao').Value := 2;
    dm.ADOProc_cidades.Parameters.ParamByName('@Codigo_Cidade').Value := DScidades.DataSet.FieldByName('Codigo_Cidade').AsInteger;
    dm.ADOProc_cidades.Parameters.ParamByName('@Nome').Value := edt_nome.Text;
    dm.ADOProc_cidades.Parameters.ParamByName('@Estado').Value := cb_estado.Text;
    dm.ADOProc_cidades.Parameters.ParamByName('@Cep_Inicial').Value := edt_cep_inicial.Text;
    dm.ADOProc_cidades.Parameters.ParamByName('@Cep_Final').Value := edt_cep_final.Text;
    dm.ADOProc_cidades.ExecProc;

    ShowMessage(dm.ADOProc_cidades.Parameters.ParamByName('@ErrMsg').Value);
    Flista_cidades.atualiza_cidades;
    Close;
  end;
end;

procedure TFcad_cidade.FormClose(Sender: TObject; var Action: TCloseAction);
//Quando o form � fechado libera mem�ria
begin
  Free;
end;

procedure TFcad_cidade.FormCreate(Sender: TObject);
//Quando o form � criado arredonda os componentes
begin
  Makerounded(edt_nome);
  Makerounded(cb_estado);
  Makerounded(edt_cep_inicial);
  Makerounded(edt_cep_final);
  Makerounded(pnl_gravar);
end;

procedure TFcad_cidade.FormShow(Sender: TObject);
//Quando o form � exibido
begin
  if estado = 1 then
  begin
    pnl_cad.Caption      := 'CADASTRAR - CIDADE';
    edt_nome.Text        := '';
    cb_estado.Text       := '';
    edt_cep_inicial.Text := '';
    edt_cep_final.Text   := '';
  end
  else
  begin
    pnl_cad.Caption      := 'EDITAR - CIDADE';
    edt_nome.Text        := DScidades.DataSet.FieldByName('Nome').AsString;
    cb_estado.Text       := DScidades.DataSet.FieldByName('Estado').AsString;
    edt_cep_inicial.Text := DScidades.DataSet.FieldByName('Cep_Inicial').AsString;
    edt_cep_final.Text   := DScidades.DataSet.FieldByName('Cep_Final').AsString;
  end;
end;

end.
