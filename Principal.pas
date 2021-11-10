unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Pedidos;

type
  TfrmPrincipal = class(TForm)
    procedure FormShow(Sender: TObject);
  private

  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses DataModule;


procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   if frmPedidos = nil then
   begin
      frmPedidos := TfrmPedidos.Create(self);
      frmPedidos.Show;
   end;

   dm.conexao.Connected := true;
end;

end.
