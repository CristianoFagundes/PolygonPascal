unit uOperator;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uPoint, uVector;


function Sum(a:Point; b:Vector):Point;
function Product(a:Vector; b:Real):Vector;

implementation

function Sum(a:Point; b:Vector):Point;
begin
  result := Point.Create(a.X + b.X, a.Y + b.Y);
end;

function Product(a:Vector; b:Real):Vector;
begin
  result := Vector.Create(a.X * b, a.Y * b);
end;


end.

