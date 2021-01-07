unit uRectangle;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uPoint;

type
  Rectangle = class
    public
      p1, p2, p3, p4: Point;
      constructor Create(_p1:Point;_p2:Point;_p3:Point;_p4:Point);
      function Clone():Rectangle;
      function ToText(format:String; separator: String; numberSetting:TFormatSettings):String;
  end;

implementation

constructor Rectangle.Create(_p1:Point;_p2:Point;_p3:Point;_p4:Point);
begin
  p1 := Point.Create(_p1);
  p2 := Point.Create(_p2);
  p3 := Point.Create(_p3);
  p4 := Point.Create(_p4);
end;

function Rectangle.Clone():Rectangle;
begin
  result := Rectangle.Create(p1,p2,p3,p4);

end;

function Rectangle.ToText(format:String; separator: String; numberSetting:TFormatSettings):String;
begin
  result := p1.ToText(format,numberSetting) + separator
  + p2.ToText(format,numberSetting) + separator
  + p3.ToText(format,numberSetting) + separator
  + p4.ToText(format,numberSetting) + separator
  + p1.ToText(format,numberSetting);
end;

end.

