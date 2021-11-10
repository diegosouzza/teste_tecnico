unit biblioteca;

interface

uses
   Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Mask,
   Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, FMTBcd,SqlExpr, Windows,
   DateUtils, DBClient, SimpleDS, DB, DBXCommon, Math, VCL.Grids;

type
   TAcao = (incluir, alterar, deletar);
   TTipoNumero = (inteiro, flutuante);

   function validar_numero(valor: string; tipo: TTipoNumero): boolean;
   function NumToFloat(valor: string): double;
   function NumToDados(valor: string): string;

   procedure habilitar_campos(grupo: TWinControl; tag: Integer; enabled: Boolean);
   procedure deletar_linha(grid: TStringGrid; linha:integer);
   procedure desativar_campos(grupo: TWinControl);
   procedure validar_campos(grupo: TWinControl);


implementation

function validar_numero(valor: string; tipo: TTipoNumero): boolean;
var
   temp_int: integer;
   temp_dob: double;
begin
   result := false;
   valor := trim(StringReplace(valor,'.','',[rfReplaceAll]));

   case tipo of
      inteiro:
      begin
         if TryStrToInt(valor,temp_int) and (StrToInt(valor) > 0) then
            result := true;
      end;
      flutuante:
      begin
         if TryStrToFloat(valor,temp_dob) and (StrToFloat(valor) > 0) then
            result := true;
      end;
   end;
end;

function NumToFloat(valor: string): double;
begin
   result := 0;
   if validar_numero(valor,flutuante) then
   begin
      valor := trim(StringReplace(valor,'.','',[rfReplaceAll]));
      result := StrToFloat(valor);
   end;
end;

function NumToDados(valor: string): string;
begin
   result := '';
   if validar_numero(valor,flutuante) then
   begin
      valor := trim(StringReplace(valor,'.','',[rfReplaceAll]));
      result := QuotedStr(StringReplace(valor,',','.',[rfReplaceAll]));
   end;
end;

procedure habilitar_campos(grupo: TWinControl; tag: Integer; enabled: Boolean);
   var
   i: Integer;
begin
   for i := 0 to grupo.controlCount-1 do
   begin
      if (grupo.controls[i].tag = tag) then
         grupo.controls[i].enabled := enabled;

      if (grupo.controls[i] is TPanel) then
         habilitar_campos(grupo.controls[i] as TPanel, tag, enabled)
      else
      if (grupo.controls[i] is TGroupBox) then
         habilitar_campos(grupo.controls[i] as TGroupBox, tag, enabled);
   end;
end;

procedure deletar_linha(grid: TStringGrid; linha: integer);
var
   qtd, i: integer;
begin
   qtd := grid.RowCount;

   if linha >= qtd then
      exit;

   if linha = (qtd-1) then
   begin
      if linha = 1 then
      begin
         for i := 0 to grid.ColCount-1 do
         grid.Cells[i,linha] := '';
      end
      else
         grid.RowCount := grid.RowCount-1;

      exit;
   end;

   repeat

      for i := 0 to grid.ColCount-1 do
         grid.Cells[i,linha] := grid.Cells[i,linha+1];

      inc(linha);

   until (linha = qtd-1);

   grid.RowCount := grid.RowCount-1;
end;

procedure desativar_campos(grupo: TWinControl);
var
   i: Integer;
begin
   for i := 0 to grupo.controlCount-1 do
   begin
      if (grupo.controls[i] is TControl) then
         grupo.controls[i].enabled := false;

      if (grupo.controls[i] is TPanel) then
         desativar_campos(grupo.controls[i] as TPanel)
      else
      if (grupo.controls[i] is TGroupBox) then
         desativar_campos(grupo.controls[i] as TGroupBox);
   end;
end;

procedure validar_campos(grupo: TWinControl);
var
   lista: TList;
   i: Integer;
begin
   lista := TList.Create;
   try
      grupo.GetTabOrderList(lista);

      if (lista.count = 0) then
         lista.Add(grupo);

      for i := 0 to lista.count-1 do
      begin
         if (TComponent(lista[i]) is TControl) and ((TComponent(lista[i]) as TControl).Enabled) then
            (TComponent(lista[i]) as TControl).Perform(cm_EXIT, 0, 0);
      end;
   finally
      lista.Free;
   end;
end;

end.
