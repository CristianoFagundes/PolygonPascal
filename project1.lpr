program project1;

uses uPoint, uRectangle, uVector, uLine, uOperator, uCalc, SysUtils;

var
  Parcelas:ArrayRectangle;
  Pontos:ArrayReal;
  i,j:Integer;
begin

     Parcelas := main(
                       Rectangle.Create(Point.Create(0, 0), Point.Create(188, 0), Point.Create(188, 24), Point.Create(0, 24)), //retangulo inicial
                       8, //divisões em X
                       4, //divisões em Y
                       4 //carreador
                       );

     //Exemplo de utilização em 3 formatos
     Writeln('------------CSV--------------');
     WriteLn(convertToCSV(Parcelas));
     Writeln('-----------------------------');

     Writeln('------------WKT--------------');
     WriteLn(convertToWKT(Parcelas));
     Writeln('-----------------------------');


     Writeln('------------ARRAY--------------');
     Pontos := convertToArrayReal(Parcelas);
     for i:=0 to length(Pontos)-1 do
     begin
       writeln('Parcela:'+IntToStr(i));
       for j:=0 to 4 do
       begin
         Writeln('  p:'+IntToStr(j)+';x:'+FloatToStr(Pontos[i][j][0])+';y:'+FloatToStr(Pontos[i][j][0]));
       end;
     end;
     Writeln('-----------------------------');


  ReadLn();

end.

