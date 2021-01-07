unit uLine;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uPoint, uVector;

type
  Line = class
    public
      startPoint:Point;
      endPoint:Point;
      constructor Create(const startP:Point; const endP:Point);
      function toVector():Vector;
      function Intersect(const r:Line):Point;
  end;

implementation

constructor Line.Create(const startP:Point; const endP:Point);
begin
  startPoint := Point.Create(startP);
  endPoint := Point.Create(endP);
end;

function Line.toVector():Vector;
begin
  result := Vector.Create(startPoint, endPoint);
end;

function Line.Intersect(const r:Line):Point;
var
   x1,y1,x2,y2,x3,y3,x4,y4:Real;
begin

  x1 := startPoint.X;
  y1 := startPoint.Y;
  x2 := endPoint.X;
  y2 := endPoint.Y;

  x3 := r.startPoint.X;
  y3 := r.startPoint.Y;
  x4 := r.endPoint.X;
  y4 := r.endPoint.Y;

  result := Point.Create(
                ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) / ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4))
                ,
                ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) / ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4))
                );
end;

end.

