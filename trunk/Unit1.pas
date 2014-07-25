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
  var
    s:string;
begin
  Settings.LoadSettings;
  s := Settings.ConnectToDb(con1,Settings.aHost,Settings.aPort, Settings.aBase,
    Settings.aUser, Settings.aPasw);
  if s='' then
    idhtpsrvr1.Active := True
   else
    ShowMessage(s);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    idhtpsrvr1.Active := False;
end;

procedure TForm1.idhtpsrvr1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  var s:string;
begin
  ZQuery1.Close;
  ZQuery1.Params[0].AsString := ARequestInfo.Params.Values['file'];
  ZQuery1.Open;
  if ZQuery1.IsEmpty then
    AResponseInfo.ResponseNo := 404
  else
    begin
      s := ZQuery1.Fields[1].AsString;
      if FileExists(s) then
        begin
          try
          AResponseInfo.ResponseNo := 200;
          AResponseInfo.ContentStream := TFileStream.Create (s, fmShareDenyNone);
          AResponseInfo.ContentType := idhtpsrvr1.MIMETable.GetFileMIMEType(s);
          AResponseInfo.Date:=Now;
          AResponseInfo.Expires:=Now;
          AResponseInfo.LastModified:=Now;
          AResponseInfo.CustomHeaders.Clear;
          AResponseInfo.CustomHeaders.Values['Content-Disposition'] :=
            ZQuery1.Fields[2].AsString
          except
            AResponseInfo.ResponseNo := 404
          end;
        end
      else
        AResponseInfo.ResponseNo := 404
    end;
  ZQuery1.Close;
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
