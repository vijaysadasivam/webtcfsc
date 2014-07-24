unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IdContext, ExtCtrls, Menus, DB, ZAbstractRODataset, ZDataset,
  ZAbstractConnection, ZConnection;

type
  TForm1 = class(TForm)
    idhtpsrvr1: TIdHTTPServer;
    trycn1: TTrayIcon;
    pm1: TPopupMenu;
    N1: TMenuItem;
    tmr1: TTimer;
    con1: TZConnection;
    ZQuery1: TZReadOnlyQuery;
    procedure idhtpsrvr1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
  uses cusettings;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  idhtpsrvr1.Active := True;
 
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    idhtpsrvr1.Active := False;
end;

procedure TForm1.idhtpsrvr1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ResponseNo := 200;
  AResponseInfo.ContentStream := TFileStream.Create ('d:\install.res.1031.dll',
    fmShareDenyNone);
  AResponseInfo.ContentType := idhtpsrvr1.MIMETable.GetFileMIMEType(
    'd:\install.res.1031.dll');
  AResponseInfo.Date:=Now;
  AResponseInfo.Expires:=Now;
  AResponseInfo.LastModified:=Now;
  AResponseInfo.CustomHeaders.Clear;
  ShowMessage(ARequestInfo.Params.Text);
  AResponseInfo.CustomHeaders.Values['Content-Disposition'] := 'filename=la-la.dll';


end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
  Form1.Hide;
  tmr1.Enabled := False;
end;

end.
