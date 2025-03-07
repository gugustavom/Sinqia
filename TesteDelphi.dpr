program TesteDelphi;

uses
  Vcl.Forms,
  Uprincipal in 'Uprincipal.pas' {Fprincipal},
  Ucad_cidade in 'Ucad_cidade.pas' {Fcad_cidade},
  Ucad_cliente in 'Ucad_cliente.pas' {Fcad_cliente},
  Udm in 'Udm.pas' {dm},
  Ulista_cidades in 'Ulista_cidades.pas' {Flista_cidades},
  Ulista_clientes in 'Ulista_clientes.pas' {Flista_clientes},
  Urelatorio_cidade in 'Urelatorio_cidade.pas' {Frelatorio_cidade};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFprincipal, Fprincipal);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
