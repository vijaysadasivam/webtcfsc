unit cUSettings;

interface
uses Classes, SysUtils, SingletonTemplate, SAVLib, ZConnection,DB;

const
  PROJECT_NAME = 'WebTCFSC';
  DEPARTMENT_NAME = 'OSAPR';
  cuser = 'user';
  cpasw = 'pasw';
  chost = 'host';
  cport = 'port';
  cdbase = 'base';
  cbase_section = 'base';
  cnet_section = 'net';
  cnet_port = 'port';
  cnet_method = 'method';
  cnet_host = 'host';

type

  TSettings = class(TSingleton)
    faUser, faPasw, faHost, faPort, faBase :string;
    faNetPort:Integer;
    faNetMethod, faNetHost: string;
  private
    procedure SetaUser(const Value: string);
    procedure SetaBase(const Value: string);
    procedure SetaHost(const Value: string);
    procedure SetaPasw(const Value: string);
    procedure SetaPort(const Value: string);
    procedure SetaNetHost(const Value: string);
    procedure SetaNetMethod(const Value: string);
    procedure SetaNetPort(const Value: integer);

  protected
    constructor Create; override;

  public

    property aUser: string read FaUser write SetaUser;
    property aPasw:string read FaPasw write SetaPasw;
    property aHost: string read FaHost write SetaHost;
    property aPort:string read FaPort write SetaPort;
    property aBase:string read FaBase write SetaBase;

    property aNetPort:integer read FaNetPort write SetaNetPort;
    property aNetHost:string read FaNetHost write SetaNetHost;
    property aNetMethod:string read FaNetMethod write SetaNetMethod;

    destructor Destroy; override;
    procedure Init;
    function ConnectToDb(aCon: TZConnection; const aHost, aPort, aDbName, aUserName,
      aPasw:string):string;
    procedure LoadSettings;

end;

function Settings: TSettings;

implementation
  uses IniFiles, Dialogs;


function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

{ TSettings }

function TSettings.ConnectToDb(aCon: TZConnection; const aHost, aPort, aDbName, aUserName,
  aPasw: string): string;
begin
  Result := '';
  if (aUserName<>'') and (aPasw<>'') and (aHost<>'') and (aPort<>'') and (aDbName<>'') then
   begin
     aCon.User := aUserName;
     aCon.Password := aPasw;
     aCon.Database := aHost + ':' + aPort + '/' + aDbName;
     //10.0.98.81:1521/tc01
     try
     aCon.Connect;
     except
       Result := 'Connection error!'
     end;
     if not aCon.Connected then
       Result := 'Connection error!';
   end
  else
   Result := 'Check connection parameters!';
end;

constructor TSettings.Create;
begin
  inherited;

end;

destructor TSettings.Destroy;
begin

  inherited;
end;

procedure TSettings.Init;
begin
  ;
end;

procedure TSettings.LoadSettings;
  var
    s:string;
    ini1:TIniFile;
begin
  ini1 := TIniFile.Create(ExtractFilePath(ParamStr(0))+
    ExtractFileNameWithoutExt(ParamStr(0))+'.ini');
  faUser := ini1.ReadString(cbase_section,cuser,'infodba');
  faPasw := ini1.ReadString(cbase_section,cpasw,'infodba');
  faHost := ini1.ReadString(cbase_section,chost,'127.0.0.1');
  faPort := ini1.ReadString(cbase_section,cport,'1521');
  faBase := ini1.ReadString(cbase_section,cdbase,'atest');
  faNetPort := ini1.ReadInteger(cnet_section,cnet_port, 8080);
  faNetMethod := ini1.ReadString(cnet_section,cnet_method,'get');
  faNetHost := ini1.ReadString(cnet_section,cnet_host,'127.0.0.1');

  FreeAndNil(ini1);
end;

procedure TSettings.SetaBase(const Value: string);
begin
  FaBase := Value;
end;

procedure TSettings.SetaHost(const Value: string);
begin
  FaHost := Value;
end;

procedure TSettings.SetaNetHost(const Value: string);
begin
  FaNetHost := Value;
end;

procedure TSettings.SetaNetMethod(const Value: string);
begin
  FaNetMethod := Value;
end;

procedure TSettings.SetaNetPort(const Value: integer);
begin
  FaNetPort := Value;
end;

procedure TSettings.SetaPasw(const Value: string);
begin
  FaPasw := Value;
end;

procedure TSettings.SetaPort(const Value: string);
begin
  FaPort := Value;
end;

procedure TSettings.SetaUser(const Value: string);
begin
  FaUser := Value;
end;

end.
