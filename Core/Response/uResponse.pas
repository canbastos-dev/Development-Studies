unit uResponse;

interface

uses system.Generics.Collections;

type
  TResponse = record
    success   : Boolean;
    ErrorCode : Integer;
    Message   : string;
    Data      : TList<TObject>;
  end;

implementation

end.
