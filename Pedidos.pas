unit Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, DataModule, Data.DBXMySQL, Datasnap.DBClient, SimpleDS, Pedido,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TCadastro = class(TfrmPedido);

  TfrmPedidos = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    btIncluir: TButton;
    btAlterar: TButton;
    btDeletar: TButton;
    ds: TDataSource;
    query: TFDQuery;
    procedure btIncluirClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btDeletarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    cad_pedidos: TCadastro;
    procedure atualizar_grid;
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.dfm}

uses biblioteca;

procedure TfrmPedidos.btIncluirClick(Sender: TObject);
begin
   if cad_pedidos = nil then
   begin
      cad_pedidos := TCadastro.Create(self,incluir,0,0);
      cad_pedidos.Show;
      Self.Enabled := false;
   end;
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
   atualizar_grid;
end;

procedure TfrmPedidos.btAlterarClick(Sender: TObject);
begin
   if cad_pedidos = nil then
   begin
      cad_pedidos := TCadastro.Create(self,alterar,0,query.FieldByName('codigo').AsInteger);
      cad_pedidos.Show;
      Self.Enabled := false;
   end;
end;

procedure TfrmPedidos.btDeletarClick(Sender: TObject);
begin
   if cad_pedidos = nil then
   begin
      cad_pedidos := TCadastro.Create(self,deletar,0,query.FieldByName('codigo').AsInteger);
      cad_pedidos.Show;
      cad_pedidos.btSalvar.Caption := '&Deletar';
      Self.Enabled := false;
   end;
end;

procedure TfrmPedidos.atualizar_grid;
begin
   with query do
   begin
      close;
      SQL.Clear;
      Open('select p.*, c.nome from pedidos p left join clientes c on p.clientes_codigo = c.codigo');
   end;
end;

end.
