unit OpenAPI.Document;

interface

uses
  System.Generics.Collections,
  OpenAPI.Types,
  OpenAPI.Info,
  OpenAPI.Server,
  OpenAPI.Path,
  OpenAPI.Components,
  OpenAPI.Security;

type
  TOpenAPITag = class;
  TOpenAPITagList = class(TObjectList<TOpenAPITag>);

  /// <summary>
  /// This is the root object of the OpenAPI document.
  /// </summary>
  TOpenAPIDocument = class
  private
    FOpenAPIInfo: TOpenAPIInfo;
    FServers: TOpenAPIServerList;
    FPaths: TOpenAPIPathItemMap;
    FComponents: TOpenAPIComponents;
    FSecurity: TOpenAPISecurityRequirementList;
    FTags: TOpenAPITagList;
    FExternalDocs: TOpenAPIExternalDoc;
    function GetOpenAPI: string;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// REQUIRED. This string MUST be the version number of the OpenAPI Specification that the OpenAPI document uses.
    /// The openapi field SHOULD be used by tooling to interpret the OpenAPI document.
    /// This is not related to the API info.version string.
    /// </summary>
    property OpenAPI: string read GetOpenAPI;
    /// <summary>
    /// REQUIRED. Provides metadata about the API. The metadata MAY be used by tooling as required.
    /// </summary>
    property Info: TOpenAPIInfo read FOpenAPIInfo;
    /// <summary>
    /// An array of Server Objects, which provide connectivity information to a target server.
    /// If the servers property is not provided, or is an empty array,
    /// the default value would be a Server Object with a url value of /.
    /// </summary>
    property Servers: TOpenAPIServerList read FServers;
    /// <summary>
    /// A list of tags used by the document with additional metadata.
    /// The order of the tags can be used to reflect on their order by the parsing tools.
    /// Not all tags that are used by the Operation Object must be declared.
    /// The tags that are not declared MAY be organized randomly or based on the tools’ logic.
    /// Each tag name in the list MUST be unique
    /// </summary>
    property Tags: TOpenAPITagList read FTags;
    /// <summary>
    /// Additional external documentation.
    /// </summary>
    property ExternalDocs: TOpenAPIExternalDoc read FExternalDocs;
    /// <summary>
    /// The available paths and operations for the API.
    /// </summary>
    property Paths: TOpenAPIPathItemMap read FPaths;
    /// <summary>
    /// An element to hold various schemas for the document.
    /// </summary>
    property Components: TOpenAPIComponents read FComponents;
    /// <summary>
    /// A declaration of which security mechanisms can be used across the API.
    /// The list of values includes alternative security requirement objects that can be used.
    /// Only one of the security requirement objects need to be satisfied to authorize a request.
    /// Individual operations can override this definition. To make security optional,
    /// an empty security requirement ({}) can be included in the array.
    /// </summary>
    property Security: TOpenAPISecurityRequirementList read FSecurity;
  end;

  /// <summary>
  /// Adds metadata to a single tag that is used by the Operation Object.
  /// It is not mandatory to have a Tag Object per tag defined in the Operation Object instances.
  /// </summary>
  TOpenAPITag = class
  private
    FName: string;
    FDescription: Nullable<string>;
    FExternalDocs: TOpenAPIExternalDoc;
    function GetExternalDocs: TOpenAPIExternalDoc;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// REQUIRED. The name of the tag.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    /// A description for the tag. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// Additional external documentation for this tag.
    /// </summary>
    property ExternalDocs: TOpenAPIExternalDoc read GetExternalDocs;
  end;

implementation

uses
  System.SysUtils;

const
  OPEN_API_VERSION = '3.1.0';

{ TOpenAPIDocument }

constructor TOpenAPIDocument.Create;
begin
  inherited Create;

  FOpenAPIInfo := TOpenAPIInfo.Create;
  FServers := TOpenAPIServerList.Create;
  FPaths := TOpenAPIPathItemMap.Create;
  FComponents := TOpenAPIComponents.Create;
  FSecurity := TOpenAPISecurityRequirementList.Create;
  FTags := TOpenAPITagList.Create;
  FExternalDocs := TOpenAPIExternalDoc.Create;
end;

destructor TOpenAPIDocument.Destroy;
begin
  FreeAndNil(FOpenAPIInfo);
  FreeAndNil(FServers);
  FreeAndNil(FPaths);
  FreeAndNil(FComponents);
  FreeAndNil(FSecurity);
  FreeAndNil(FTags);
  FreeAndNil(FExternalDocs);
  inherited Destroy;
end;

function TOpenAPIDocument.GetOpenAPI: string;
begin
  Result := OPEN_API_VERSION;
end;

{ TOpenAPITag }

constructor TOpenAPITag.Create;
begin
  inherited Create;
  FExternalDocs := nil;
end;

destructor TOpenAPITag.Destroy;
begin
  if Assigned(FExternalDocs) then
    FreeAndNil(FExternalDocs);
  inherited Destroy;
end;

function TOpenAPITag.GetExternalDocs: TOpenAPIExternalDoc;
begin
  if not Assigned(FExternalDocs) then
    FExternalDocs := TOpenAPIExternalDoc.Create;
  Result := FExternalDocs;
end;

end.
