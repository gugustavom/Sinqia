unit Uprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFprincipal = class(TForm)
    Panel1: TPanel;
    pnl_cidades: TPanel;
    pnl_clientes: TPanel;
    pnl_relatorios: TPanel;
    btn_cidades: TSpeedButton;
    btn_clientes: TSpeedButton;
    btn_relatorios: TSpeedButton;
    pnl_acoes_cidades: TPanel;
    pnl_acoes_clientes: TPanel;
    btn_cad_cidade: TSpeedButton;
    btn_lista_cidade: TSpeedButton;
    btn_cad_cliente: TSpeedButton;
    btn_lista_cliente: TSpeedButton;
    Image4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btn_cidadesClick(Sender: TObject);
    procedure btn_clientesClick(Sender: TObject);
    procedure btn_relatoriosClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure btn_cad_cidadeClick(Sender: TObject);
    procedure btn_cad_clienteClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btn_lista_cidadeClick(Sender: TObject);
    procedure btn_lista_clienteClick(Sender: TObject);
    procedure btn_relat_cidadeClick(Sender: TObject);
    procedure btn_relat_clientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fprincipal: TFprincipal;

implementation

{$R *.dfm}

uses Ucad_cidade, Ucad_cliente, Ulista_cidades, Ulista_clientes, Urelatorio_cidade;

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

procedure TFprincipal.btn_cad_cidadeClick(Sender: TObject);
//Bot�o CADASTRA cidades
begin
  Application.CreateForm(TFcad_cidade, Fcad_cidade);
  Fcad_cidade.estado := 1;
  Fcad_cidade.Show;
end;

procedure TFprincipal.btn_cidadesClick(Sender: TObject);
//Bot�o abre op��es de cadastro e consulta CIDADES
begin
  pnl_acoes_cidades.Visible   := True;
  pnl_acoes_clientes.Visible  := False;
end;

procedure TFprincipal.btn_clientesClick(Sender: TObject);
//Bot�o abre op��es de cadastro e consulta CLIENTES
begin
 pnl_acoes_clientes.Visible  := True;
 pnl_acoes_cidades.Visible   := False;
end;

procedure TFprincipal.btn_lista_cidadeClick(Sender: TObject);
//Bot�o CONSULTA cidades
begin
  Application.CreateForm(TFlista_cidades, Flista_cidades);
  Flista_cidades.Show;
end;

procedure TFprincipal.btn_lista_clienteClick(Sender: TObject);
//Bot�o CONSULTA clientes
begin
  Application.CreateForm(TFlista_clientes, Flista_clientes);
  Flista_clientes.Show;
end;

procedure TFprincipal.btn_relatoriosClick(Sender: TObject);
//Bot�o RELATORIOS
begin
  pnl_acoes_cidades.Visible   := False;
  pnl_acoes_clientes.Visible  := False;

  Application.CreateForm(TFrelatorio_cidade, Frelatorio_cidade);
  Frelatorio_cidade.Show;

end;

procedure TFprincipal.btn_relat_cidadeClick(Sender: TObject);
//Bot�o relatorio CIDADES
begin
  pnl_acoes_cidades.Visible  := False;
  pnl_acoes_clientes.Visible := False;
  Application.CreateForm(TFrelatorio_cidade, Frelatorio_cidade);
  Frelatorio_cidade.Show;
end;

procedure TFprincipal.btn_relat_clientesClick(Sender: TObject);
begin
  //Application.
end;

procedure TFprincipal.FormClick(Sender: TObject);
//Quando o form � clicado as op��es somem
begin
  pnl_acoes_cidades.Visible   := False;
  pnl_acoes_clientes.Visible  := False;
end;

procedure TFprincipal.FormCreate(Sender: TObject);
//Quando o form � criado arredonda os componentes
begin
  MakeRounded(pnl_cidades);
  MakeRounded(pnl_clientes);
  MakeRounded(pnl_relatorios);
  MakeRounded(pnl_acoes_cidades);
  MakeRounded(pnl_acoes_clientes);

  pnl_acoes_cidades.Visible   := False;
  pnl_acoes_clientes.Visible  := False;
end;

procedure TFprincipal.Image4Click(Sender: TObject);
//Quando a imagem � clicado as op��es somem
begin
  pnl_acoes_cidades.Visible   := False;
  pnl_acoes_clientes.Visible  := False;
end;

procedure TFprincipal.btn_cad_clienteClick(Sender: TObject);
//Bot�o CADASTRO clientes
begin
  Application.CreateForm(TFcad_cliente, Fcad_cliente);
  Fcad_cliente.estado := 1;
  Fcad_cliente.Show;
end;

end.
