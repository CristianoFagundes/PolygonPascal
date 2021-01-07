unit uPoint;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  Point = class
    public
      X: Real;
      Y: Real;
      constructor Create(_X:Real; _Y:Real);
      constructor Create(p1:Point);
      function Clone(p1:Point):Point;
      function ToText(format:String; numberSetting:TFormatSettings):String;
  end;

implementation

constructor Point.Create(_X:Real; _Y:Real);
BEGIN
  X:=_X;
  Y:=_Y;
end;

constructor Point.Create(p1:Point);
begin
  X:=p1.X;
  Y:=p1.Y;
end;

function Point.Clone(p1:Point):Point;
begin
  result:=Point.Create(p1);
end;

function Point.ToText(format:String; numberSetting:TFormatSettings):String;
var
  aux : String;
begin
  aux := StringReplace(format,'{X}', FloatToStr(X,numberSetting), [rfIgnoreCase]);
  aux := StringReplace(aux,'{Y}', FloatToStr(Y,numberSetting), [rfIgnoreCase]);
  result := aux;
end;



end.

