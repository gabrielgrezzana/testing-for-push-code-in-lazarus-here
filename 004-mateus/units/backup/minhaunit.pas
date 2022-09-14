unit minhaunit;

{$mode ObjFPC}{$H+}

interface


uses
  Classes, SysUtils,StdCtrls;

type

 TMeuCallback = function():String of object;

 TObjeto_um=class
   private
   public
     minhaString:String;
 end;


 { TMeuobjeto }

 TMeuobjeto=class(TObject)
   private
     FMinhaVariavel:String;
     FMeuLabel:TObjeto_um;
     FMeuCallback:TMeuCallback;
     procedure setGabriel;
   public
     constructor Create;
     destructor Destroy; override;
     procedure setMateus;
     property minhavariavel:String read FMinhaVariavel;
     property MeuCallback:TMeuCallback read FMeuCallback write FMeuCallback;

 end;

 { TMeuObjetoCustomizado }

 TMeuObjetoCustomizado=Class(TMeuobjeto)
   public
     procedure setVariavel(AValor:String);
     function getVariavel:String;

 end;



implementation

{ TMeuObjetoCustomizado }

procedure TMeuObjetoCustomizado.setVariavel(AValor: String);
begin
  FMinhaVariavel:=AValor;
  MeuCallback();
end;

function TMeuObjetoCustomizado.getVariavel: String;
begin
  Result:=FMinhaVariavel;
end;

{ TMeuobjeto }

procedure TMeuobjeto.setGabriel;
begin
  FMinhaVariavel:='Gabriel';
end;

constructor TMeuobjeto.Create;
begin
  inherited Create;
  setGabriel;
  FMeuLabel:=TObjeto_um.Create;
end;

destructor TMeuobjeto.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FMeuLabel);
end;

procedure TMeuobjeto.setMateus;
begin
  FMinhaVariavel:='Mateus';
end;

end.

