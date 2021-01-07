unit uVector;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uPoint;

type
  Vector = class(Point)
    constructor Create(p1:Point; p2:Point);
    constructor Create(_X:Real; _Y:Real);
    constructor Create(v:Vector);
    function Clone():Vector;
    function Size():Real;
    function Unitario():Vector;
  end;

implementation

constructor Vector.Create(p1:Point; p2:Point);
begin
  X := p2.X - p1.X;
  Y := p2.Y - p1.Y;
end;

constructor Vector.Create(_X:Real; _Y:Real);
begin
  X := _X;
  Y := _Y;
end;

constructor Vector.Create(v:Vector);
begin
  X := v.X;
  Y := v.Y;
end;

function Vector.Clone():Vector;
begin
  result := Vector.Create(X, Y);
end;

function Vector.Size():Real;
begin
  result := Sqrt(Sqr(X)+Sqr(Y));
end;

function Vector.Unitario():Vector;
var
  auxsize:real;
begin
 auxsize := size();
 result := Vector.Create(X / auxsize, Y / auxsize);
end;

end.

