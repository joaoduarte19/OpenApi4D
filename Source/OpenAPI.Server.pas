unit OpenAPI.Server;

interface

uses
  System.Generics.Collections,
  OpenAPI.Types;

type
  TOpenAPIServerVariable = class;

  TServerVariableMap = class(TObjectDictionary<string, TOpenAPIServerVariable>)
  public
    constructor Create;
  end;

  TOpenAPIServer = class
  private
    FUrl: string;
    FDescription: Nullable<string>;
    FVariables: TServerVariableMap;
    function GetVariables: TServerVariableMap;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// REQUIRED. A URL to the target host. This URL supports Server Variables and MAY be relative,
    /// to indicate that the host location is relative to the location where the OpenAPI document is being served.
    /// Variable substitutions will be made when a variable is named in {brackets}.
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// An optional string describing the host designated by the URL. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// A map between a variable name and its value. The value is used for substitution in the server's URL template.
    /// </summary>
    property Variables: TServerVariableMap read GetVariables;
  end;

  TOpenAPIServerList = class(TObjectList<TOpenAPIServer>);

  TOpenAPIServerVariable = class
  private
    FEnum: TList<string>;
    FDefault: string;
    FDescription: Nullable<string>;
    function GetEnum: TList<string>;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// An enumeration of string values to be used if the substitution options are from a limited set. The array MUST NOT be empty.
    /// </summary>
    property Enum: TList<string> read GetEnum;
    /// <summary>
    /// REQUIRED. The default value to use for substitution, which SHALL be sent if an alternate value is not supplied.
    /// Note this behavior is different than the Schema Object's treatment of default values, because in those cases parameter values are optional.
    /// If the enum is defined, the value MUST exist in the enum's values.
    /// </summary>
    property &Default: string read FDefault write FDefault;
    /// <summary>
    /// An optional description for the server variable. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
  end;

implementation

uses
  System.SysUtils;

{ TOpenAPIServer }

constructor TOpenAPIServer.Create;
begin
  inherited Create;
  FVariables := nil;
end;

destructor TOpenAPIServer.Destroy;
begin
  if Assigned(FVariables) then
    FreeAndNil(FVariables);
  inherited;
end;

function TOpenAPIServer.GetVariables: TServerVariableMap;
begin
  if not Assigned(FVariables) then
    FVariables := TServerVariableMap.Create;
  Result := FVariables;
end;

{ TOpenAPIServerVariable }

constructor TOpenAPIServerVariable.Create;
begin
  inherited Create;
  FEnum := nil;
end;

destructor TOpenAPIServerVariable.Destroy;
begin
  if Assigned(FEnum) then
    FreeAndNil(FEnum);
  inherited Destroy;
end;

function TOpenAPIServerVariable.GetEnum: TList<string>;
begin
  if not Assigned(FEnum) then
    FEnum := TList<string>.Create;
  Result := FEnum;
end;

{ TServerVariableMap }

constructor TServerVariableMap.Create;
begin
  inherited Create([doOwnsValues]);
end;

end.
