unit Urelatorio_cidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, ppCtrls, ppVar, ppPrnabl,
  ppBands, ppCache, ppDesignLayer, ppParameter;

type
  TFrelatorio_cidade = class(TForm)
    Panel1: TPanel;
    lbl_filtrar: TLabel;
    cb_filtrar: TComboBox;
    lbl_cod: TLabel;
    pnl_codigo: TPanel;
    edt_de: TEdit;
    edt_ate: TEdit;
    lbl_ate: TLabel;
    pnl_estado: TPanel;
    cb_estado: TComboBox;
    DBGrid1: TDBGrid;
    pnl_botoes: TPanel;
    pnl_filtrar: TPanel;
    pnl_imprimir: TPanel;
    btn_filtrar: TSpeedButton;
    btn_imprimir: TSpeedButton;
    DScidades: TDataSource;
    PPrelatorio: TppReport;
    ppDBPipeline1: TppDBPipeline;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    pplbl_tipo_filtro: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppImage1: TppImage;
    ppTitleBand1: TppTitleBand;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel11: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    procedure cb_filtrarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_filtrarClick(Sender: TObject);
    procedure btn_imprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frelatorio_cidade: TFrelatorio_cidade;

implementation

{$R *.dfm}

uses Udm;

procedure MakeRounded(Control: TWinControl);
//Procedure que arredonda os componentes
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

procedure TFrelatorio_cidade.btn_filtrarClick(Sender: TObject);
begin
  if cb_filtrar.ItemIndex <> -1 then
  begin
    { Se for estado, limitar apenas a 1 campo }
    if cb_filtrar.ItemIndex = 1 then
    begin
      if cb_estado.Text <> '' then
      begin
        with dm.ADOqry_cidades do
        begin
          Filtered := False;
          Filter   := 'Estado LIKE ' + QuotedStr(cb_estado.Text);
          Filtered := True;
        end;
      end
      else
        ShowMessage('Preencha todos os campos antes de continuar!');
    end
    else
    begin
      if (edt_de.Text <> '') AND (edt_ate.Text <> '') then
      begin
        with dm.ADOqry_cidades do
        begin
          Filtered := False;
          Filter   := 'Codigo_Cidade >= ' + QuotedStr(edt_de.Text)+ ' AND Codigo_Cidade <= ' + QuotedStr(edt_ate.Text);
          Filtered := True;
        end;
      end
      else
        ShowMessage('Preencha todos os campos antes de continuar!');
    end
  end
  else
    ShowMessage('Informe algum tipo de filtro antes de continuar!');
end;

procedure TFrelatorio_cidade.btn_imprimirClick(Sender: TObject);
begin
  if DScidades.DataSet.RecordCount = 0 then
  begin
    ShowMessage('N�o h� registros � serem exibidos!');
    abort;
  end;

  PPlbl_tipo_filtro.Text := 'Tipo de filtro: ' + cb_filtrar.Text;

  if cb_filtrar.ItemIndex = -1 then
  begin
    ppLabel10.Visible := False;
  end
  else if cb_filtrar.Text = 'Estado' then
  begin
    pplbl_tipo_filtro.Text := 'Filtrando pelo estado: ' + cb_estado.Text;
    ppLabel10.Visible := True;
  end
  else if cb_filtrar.Text = 'C�digo da Cidade' then
  begin
    pplbl_tipo_filtro.Text := 'Filtrando do c�digo : ' + edt_de.Text + ' at� ' + edt_ate.Text;
    ppLabel10.Visible := True;
  end;
  ppRelatorio.Print;
end;

procedure TFrelatorio_cidade.cb_filtrarChange(Sender: TObject);
begin
  if cb_filtrar.Text = 'Estado' then
  begin
    edt_ate.ReadOnly   := True;
    pnl_estado.Visible := True;
    lbl_cod.Visible    := True;
    pnl_codigo.Visible := False;
    lbl_cod.Caption    := 'Informe a sigla do estado';
  end

  else if cb_filtrar.Text = 'C�digo da Cidade' then
  begin
    edt_de.Visible := True;
    edt_ate.Visible := True;
    lbl_ate.Visible := True;
    lbl_cod.Visible := True;

    edt_ate.ReadOnly   := False;
    pnl_estado.Visible  := False;
    pnl_codigo.Visible  := True;
    lbl_cod.Caption := 'Informe o C�digo Inicial e o C�digo Final';
  end;

//  else if cb_filtrar.Text = 'Clientes' then
//  begin
//    edt_de.Visible := False;
//    edt_ate.Visible := False;
//    lbl_ate.Visible := False;
//    lbl_cod.Visible := False;
//    pnl_estado.Visible  := False;
//    pnl_codigo.Visible  := False;
//  end
//
//  else
//  begin
//    edt_de.Visible := True;
//    edt_ate.Visible := True;
//    lbl_ate.Visible := True;
//    lbl_cod.Visible := True;
//
//    edt_ate.ReadOnly   := False;
//    pnl_estado.Visible  := False;
//    pnl_codigo.Visible  := True;
//    lbl_cod.Caption := 'Informe o C�digo Inicial e o C�digo Final dos Clientes';
//  end;
end;

procedure TFrelatorio_cidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Free;
end;

procedure TFrelatorio_cidade.FormCreate(Sender: TObject);
begin
  DScidades.DataSet.Close;
  DScidades.DataSet.Open;

  MakeRounded(edt_de);
  MakeRounded(edt_ate);
  MakeRounded(pnl_filtrar);
  MakeRounded(pnl_imprimir);

  edt_de.Visible    := False;
  edt_ate.Visible   := False;
  lbl_ate.Visible   := False;
  lbl_cod.Visible   := False;
  pnl_estado.Visible := False;
end;

end.
