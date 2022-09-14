unit fmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls
  //aqui estou importando a lib fphttpserver para dar comando como get
  //e importando minhaunit
  , fphttpserver
  ,minhaunit
  ;

type

  { TForm1 }

  //TForm1 vai herdar oque tem dentro de TForm que é o pai, nele tem comandos de
  //create e destroy.
  TForm1 = class(TForm)
    Button1: TButton;//botao que coloquei no meu form
    Edit1: TEdit;    //botao que coloquei no meu form
    procedure Button1Click(Sender: TObject); //estou ligando uma procedure no meu botao
    procedure FormCreate(Sender: TObject);
  private  //aqui eu declaro funcoes ou procedures ou variaveis para usar apenas dentro dessa unit aqui,
           //caso eu queira usar alguma coisa que está aqui preciso declarar no public.
           //ou preciso criar outra variavel que vai receber valor do meu private e colocar read dizendo que a variavel do public vai apenas ler a variavel private e ai sim consigo puxar ela
           //em outra unit.
    FServer:TFPHttpServer; //aqui estou declarando que meu FServer tem as propriedades do meu TFPHttpServer.
    meuobjeto:TMeuObjetoCustomizado;  //meu objeto vai receber proprioedades do TMeuObjetoCustomizado
    function responsePong:String; //criando uma funcao, dando um nome para ela e dizendo que ela vai retornar uma string
  public
    function EsteCallback():String; //criando uma funcao, dando um nome para ela e dizendo que ela vai retornar uma string
    procedure Gabriel(Sender:TObject;var ARequest:TFPHTTPConnectionRequest;var AResponse:TFPHTTPConnectionResponse); //ISTO AQUI É PADRÃO SEMPRE VAI TER QUE EXISTIR
    const                                                                                                           //crio essa procedure
      ping='/PING';  //declarando rotas                                                                            //e declaro minhas rotas
      pong='/PONG';  //declarando rotas
      opa='/OPA';    //declarando rotas

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  {                //manha para que meu form que é criado obrigatoriamente rode em segundo plano
  while true do
  begin
    Sleep(1000);
    meuobjeto:=TMeuobjeto.Create;
  end;
  }
  meuobjeto:=TMeuObjetoCustomizado.Create;   //meuobjeto vai receber as propriedades do TMeuObjetoCustomizado e dou .Create para criar ele
  meuobjeto.MeuCallback:=@EsteCallback;      //meuobjeto vai acessar a propriedade dentro do TMeuObjetoCustomizado e vai chamar a function MeuCallBack que vai chamar EsteCallBack
  {                                          //esse @ na frente é que eu estou dizendo para o windowns encontrar a onde está essa 'function' ou 'procedure' pois quando o codigo está em execução
                                             //é assim que ele procura por ela. é assim que faco uma funcao receber outra funcao.;
  ShowMessage(meuobjeto.minhavariavel);
  meuobjeto.setMateus;
  ShowMessage(meuobjeto.minhavariavel);
  meuobjeto.setVariavel('Marcos');
  ShowMessage(meuobjeto.getVariavel);
  FreeAndNil(meuobjeto);
  }
  FServer:=TFPHttpServer.Create(Nil);  //criando meu TFPHttpServer e passando a propriedade nil pra ele, que é null;
  FServer.Port:=2000;   //declarando minha porta para a execucao do meu programa
  FServer.OnRequest:=@Gabriel;  //FServer entra na propriedade OnRequest e passa procedure @Gabriel para o windowns encontrar a onde está localizada
                                //esse OnRequest é uma propriedade do proprio TFPHttpServer;

  FServer.Active:=True; //aqui que a mágica acontece, quando eu passo esse valor como true. ele roda automaticamente, minha aplicacao web.

end;

function TForm1.responsePong: String;    //chamando uma funcao que criei la em cima, so preciso chamar ela do msm jeito aqui tbm
begin
  Result:='{"teste":"ping"}'; //e aqui so estou dizendo que ela vai retornar esse json ai
end;

procedure TForm1.Button1Click(Sender: TObject); //aqui chamo uma funcao criada la em cima
begin
  meuobjeto.setVariavel(Edit1.Text);//aqui estou dizendo que quando o botao for apertado ele vai trocar o valor do meu Edit1.Text para o valor que foi digitado
end;

function TForm1.EsteCallback: String; //chamando uma funcao que criei ela la em cima mas ela nao está fazendo nada '-'
begin
end;

procedure TForm1.Gabriel(Sender: TObject; //TForm1.Gabriel vai enviar um TOject
  var ARequest: TFPHTTPConnectionRequest;  //ARequest vai receber as propriedades do TFPHTTPConnectionRequest
  var AResponse: TFPHTTPConnectionResponse); //AResponse vai receber as propriedades do TFPHTTPConnectionRequest
var
  uri:String; //declarando URI é onde o cara digita la o site q ele quer http:localhost:3000/algumacoisa
  json:String; //declarando que json é uma string
  method:String;//declarando que method é string
begin
  uri:=ARequest.URI;  //chamando uri e recebendo ARequest e entrando na propriedade URI. (uri é minha URL)
  json:=ARequest.Content; //ARequest acredito ser uma requisição do meu cliente
  method:=ARequest.Method;
  //ShowMessage(json+' '+method);
  case UpperCase(uri) of  //passando minha uri para uppercase caso o abobado coloque errado na url
      ping: if (method='GET') then AResponse.Content:='{"teste":"pong"}' else AResponse.Code:=404 ;   //aqui estou setando um metodo com if, o sistema vai ler se o method é get se for
      pong: if (method='POST') then AResponse.Content:=responsePong else AResponse.Code:=502;        //ele vai ler e fazer a requisicao se nao vai dar 404
      opa: AResponse.Content:='{"teste":"eita"}' ;
      else AResponse.Code:=404;
  end;
end;

end.

