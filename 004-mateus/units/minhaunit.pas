unit minhaunit;

{$mode ObjFPC}{$H+}

interface


uses
  Classes, SysUtils,StdCtrls;     //importando coisas que vou usar na minha unit.

type

 TMeuCallback = function():String of object; //declarando uma function anonima e dizendo que ela vai retornar uma string de um objeto

 TObjeto_um=class //declarando que meu TObjeto vai receber as propriedades de um objeto padrao do frepascal
   private
   public
     minhaString:String; //declarando uma variavel que vai receber uma string como valor
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
     destructor Destroy; override;  //esse override que dizer que é pra ele usar ESSA aplicacao de destroy que fiz porque ele ja vem com uma padrao. overrider faz ele usar a minha.
     procedure setMateus; //criando uma procedure
     property minhavariavel:String read FMinhaVariavel; //aqui estou declarando que minha variavel pode usar LIDA de qualquer lugar que eu chamar e importar essa unit.
     property MeuCallback:TMeuCallback read FMeuCallback write FMeuCallback; //declarando q minha vaviavel pode ser lida e pode ser escrita ou seja colocado um novo valor nela.

 end;

 { TMeuObjetoCustomizado }

 TMeuObjetoCustomizado=Class(TMeuobjeto)        //criando meu objetocustomizado
   public
     procedure setVariavel(AValor:String);      //declarando minha procedure do meu objeto, nome dela, declarando que AValor vai ter uma string
     function getVariavel:String;   //declarando uma function do meu objeto;

 end;



implementation

{ TMeuObjetoCustomizado }

procedure TMeuObjetoCustomizado.setVariavel(AValor: String); //chamando procedure do meu objeto e chamando outra procedure setVariavel
begin
  FMinhaVariavel:=AValor; //dizendo que FMinhVariavel vai receber AValor como resposta. que nao sei ainda qual valor sera pois nao foi colocado em codigo
  MeuCallback(); //chamando funcao MeuCallback e executando
end;

function TMeuObjetoCustomizado.getVariavel: String;
begin
  Result:=FMinhaVariavel;
end;

{ TMeuobjeto }

procedure TMeuobjeto.setGabriel;
begin
  FMinhaVariavel:='Gabriel';   //passando valor de para minha Variavel
end;

constructor TMeuobjeto.Create;
begin
  inherited Create;   //nao lembro oque é isso
  setGabriel;        //chamando procedure
  FMeuLabel:=TObjeto_um.Create;
end;

destructor TMeuobjeto.Destroy;    //destroindo meu objeto, detalhe que so posso destruir meu objeto quando eu tenho certeza que nao vou mais usar ele no codigo, caso contrario ira quebrar.
begin
  inherited Destroy;          //aqui na verdade que estou destroindo de fato
  FreeAndNil(FMeuLabel);      //FreeAndNil estou liberando meu objeto
end;

procedure TMeuobjeto.setMateus;
begin
  FMinhaVariavel:='Mateus';   //colocando um valor na minha variavel e declarando uma nova procedure no caso,
  //quando eu chamar meu objeto la no fmain, eu escolho qual procedure ou funcao que quero chamar, logo se eu chamar essa aqui o valor q vai aparecer na tela sera 'Mateus'
  //entao se eu chamar outra funcao tera outro nome como valor.

end;

end.

