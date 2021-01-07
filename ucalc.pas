unit uCalc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uRectangle, uPoint, uVector, uLine, uOperator;

type
  ArrayPoint = array of Point;
  ArrayLine = array of Line;
  ArrayRectangle = array of Rectangle;
  ArrayReal = array of array of array of Real;


function main(Total:Rectangle;xDivision:Integer;yDivision:Integer;carreador:Real):ArrayRectangle;
function convertToCSV(Parcelas:ArrayRectangle):String;
function convertToWKT(Parcelas:ArrayRectangle):String;
function convertToArrayReal(Parcelas:ArrayRectangle):ArrayReal;

implementation

function convertToCSV(Parcelas:ArrayRectangle):String;
var
   Aux:string;
   i:Integer;
   numberSetting: TFormatSettings;
begin
  numberSetting.DecimalSeparator:=',';
  aux := ('Descricao;X;Y')+sLineBreak;
  for i := 0 to length(Parcelas)-1 do
  begin
      aux := aux + (Parcelas[i].ToText('Parcela' + IntToStr(i) + ';{X};{Y}', sLineBreak, numberSetting)+sLineBreak);
  end;
  result := aux;
end;

function convertToWKT(Parcelas:ArrayRectangle):String;
var
   Aux:string;
   i:Integer;
   numberSetting: TFormatSettings;
begin
  numberSetting.DecimalSeparator:='.';
  aux := ('MULTIPOLYGON(');
  for i := 0 to length(Parcelas)-1 do
  begin
      if i>0 then
         aux := aux+',';
      aux := aux + '((' + (Parcelas[i].ToText('{X} {Y}', ',', numberSetting)) + '))';
  end;
  aux := aux + ')';
  result := aux;
end;

function convertToArrayReal(Parcelas:ArrayRectangle):ArrayReal;
var
   Aux:ArrayReal;
   i:Integer;
begin
  SetLength(aux,length(Parcelas));
  for i := 0 to length(Parcelas)-1 do
  begin
      SetLength(aux[i],5);
      SetLength(aux[i][0],2);
      SetLength(aux[i][1],2);
      SetLength(aux[i][2],2);
      SetLength(aux[i][3],2);
      SetLength(aux[i][4],2);

      aux[i][0][0] := Parcelas[i].p1.X;
      aux[i][0][1] := Parcelas[i].p1.Y;
      aux[i][1][0] := Parcelas[i].p2.X;
      aux[i][1][1] := Parcelas[i].p2.Y;
      aux[i][2][0] := Parcelas[i].p3.X;
      aux[i][2][1] := Parcelas[i].p3.Y;
      aux[i][3][0] := Parcelas[i].p4.X;
      aux[i][3][1] := Parcelas[i].p4.Y;
      aux[i][4][0] := Parcelas[i].p1.X;
      aux[i][4][1] := Parcelas[i].p1.Y;
  end;
  result := aux;
end;

function SubDivisoes(Division:Integer; carreador:Real; reta:Line):ArrayPoint;
var
   aux : ArrayPoint;
   bordaSize,utilSize,tambButton : Real;
   i : Integer;
begin
  SetLength(aux,Division*2);
  bordaSize := (Division - 1) * carreador;
  utilSize := reta.toVector().size() - bordaSize;
  tambButton := utilSize / Division;

  for i := 0 to Division-1 do
  begin
       aux[i*2] := Sum(reta.startPoint ,  Product(reta.toVector().unitario() , (carreador * (i + 0) + (tambButton) * i)));
       aux[i*2+1] := Sum(reta.startPoint ,  Product(reta.toVector().unitario() , (carreador * (i + 0) + (tambButton) * (i + 1))));
  end;
  result := aux;
end;

function main(Total:Rectangle;xDivision:Integer;yDivision:Integer;carreador:Real):ArrayRectangle;
var
   y_i,x_i,i:Integer;
   p1, p2, p3, p4:Point;
   divP1_P2,divP3_P4,divP2_P3,divP4_P1:ArrayPoint;
   hReta,vReta:ArrayLine;
   Parcelas:ArrayRectangle;
   aux:Integer;
begin
  SetLength(divP1_P2,xDivision);
  SetLength(divP3_P4,xDivision);
  SetLength(divP2_P3,yDivision);
  SetLength(divP4_P1,yDivision);
  SetLength(hReta,xDivision*2);
  SetLength(vReta,yDivision*2);
  SetLength(Parcelas,xDivision*yDivision);

  divP1_P2 := SubDivisoes(xDivision, carreador, Line.Create(Total.p1, Total.p2));
  divP2_P3 := SubDivisoes(yDivision, 0, Line.Create(Total.p2, Total.p3));
  divP3_P4 := SubDivisoes(xDivision, carreador, Line.Create(Total.p4, Total.p3));
  divP4_P1 := SubDivisoes(yDivision, 0, Line.Create(Total.p1, Total.p4));

  for i := 0 to xDivision-1 do
  begin
      hReta[(i*2)] := (Line.Create(divP1_P2[i * 2], divP3_P4[i * 2]));
      hReta[(i*2)+1] := (Line.Create(divP1_P2[(i * 2) + 1], divP3_P4[(i * 2) + 1]));
  end;

  for i := 0 to yDivision-1 do
  begin
      vReta[(i*2)] := (Line.Create(divP2_P3[i * 2], divP4_P1[i * 2]));
      vReta[(i*2)+1] := (Line.Create(divP2_P3[(i * 2) + 1], divP4_P1[(i * 2) + 1]));
  end;

  for y_i := 0 to yDivision-1 do
  begin
       for x_i := 0 to xDivision-1 do
      begin
          aux := ((y_i*xDivision) + (x_i));
          p1 := hReta[x_i * 2].Intersect(vReta[y_i * 2]);
          p2 := hReta[(x_i * 2) +1].Intersect(vReta[y_i * 2]);
          p4 := hReta[x_i * 2].Intersect(vReta[(y_i * 2) + 1]);
          p3 := hReta[(x_i * 2) + 1].Intersect(vReta[(y_i * 2) + 1]);

          Parcelas[aux] := (Rectangle.Create(p1, p2, p3, p4));
      end;
  end;

  result := Parcelas;
end;



end.

