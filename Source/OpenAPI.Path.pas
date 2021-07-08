unit OpenAPI.Path;

interface

uses
  System.Generics.Collections,
  OpenAPI.Types,
  OpenAPI.Server,
  OpenAPI.Schema,
  OpenAPI.Security;

type
  TOpenAPIPathItem = class;
  TOpenAPIPathItemMap = class(TOpenAPIObjectMap<TOpenAPIPathItem>);

  TOpenAPIOperation = class;

  TOpenAPIExternalDoc = class;

  TOpenAPIParameter = class;
  TOpenAPIParameterMap = class(TOpenAPIObjectMap<TOpenAPIParameter>);
  TOpenAPIParameterList = class(TObjectList<TOpenAPIParameter>);

  TOpenAPIRequestBody = class;
  TOpenAPIRequestBodyMap = class(TOpenAPIObjectMap<TOpenAPIRequestBody>);

  TOpenAPIResponse = class;
  TOpenAPIResponseMap = class(TOpenAPIObjectMap<TOpenAPIResponse>);

  TOpenAPIExample = class;
  TOpenAPIExampleMap = class(TOpenAPIObjectMap<TOpenAPIExample>);

  TOpenAPIMediaType = class;
  TOpenAPIMediaTypeMap = class(TOpenAPIObjectMap<TOpenAPIMediaType>);

  TOpenAPIEncoding = class;
  TOpenAPIEncodingMap = class(TOpenAPIObjectMap<TOpenAPIEncoding>);

  TOpenAPIHeader = class;
  TOpenAPIHeaderMap = class(TOpenAPIObjectMap<TOpenAPIHeader>);

  TOpenAPILink = class;
  TOpenAPILinkMap = class(TOpenAPIObjectMap<TOpenAPILink>);

  /// <summary>
  /// Describes the operations available on a single path. A Path Item MAY be empty, due to ACL constraints.
  /// The path itself is still exposed to the documentation viewer but they will not know which
  /// operations and parameters are available.
  /// </summary>
  TOpenAPIPathItem = class
  private
    FRef: Nullable<string>;
    FSummary: Nullable<string>;
    FDescription: Nullable<string>;
    FOperationGet: TOpenApiOperation;
    FOperationPut: TOpenApiOperation;
    FOperationPost: TOpenApiOperation;
    FOperationDelete: TOpenApiOperation;
    FOperationOptions: TOpenApiOperation;
    FOperationHead: TOpenApiOperation;
    FOperationPatch: TOpenApiOperation;
    FOperationTrace: TOpenApiOperation;
    FServers: TOpenAPIServerList;
    FParameters: TOpenAPIParameterList;
    function GetServers: TOpenAPIServerList;
    function GetParameters: TOpenAPIParameterList;
    function GetOperationDelete: TOpenAPIOperation;
    function GetOperationGet: TOpenAPIOperation;
    function GetOperationHead: TOpenAPIOperation;
    function GetOperationOptions: TOpenAPIOperation;
    function GetOperationPatch: TOpenAPIOperation;
    function GetOperationPost: TOpenAPIOperation;
    function GetOperationPut: TOpenAPIOperation;
    function GetOperationTrace: TOpenAPIOperation;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Allows for a referenced definition of this path item. The referenced structure MUST be in the form of a Path Item Object.
    /// In case a Path Item Object field appears both in the defined object and the referenced object, the behavior is undefined.
    /// </summary>
    property Ref: Nullable<string> read FRef write FRef;
    /// <summary>
    /// An optional, string summary, intended to apply to all operations in this path.
    /// </summary>
    property Summary: Nullable<string> read FSummary write FSummary;
    /// <summary>
    /// An optional, string description, intended to apply to all operations in this path. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// A definition of a GET operation on this path.
    /// </summary>
    property Get: TOpenAPIOperation read GetOperationGet;
    /// <summary>
    /// A definition of a PUT operation on this path.
    /// </summary>
    property Put: TOpenAPIOperation read GetOperationPut;
    /// <summary>
    /// A definition of a POST operation on this path.
    /// </summary>
    property Post: TOpenAPIOperation read GetOperationPost;
    /// <summary>
    /// A definition of a DELETE operation on this path.
    /// </summary>
    property Delete: TOpenAPIOperation read GetOperationDelete;
    /// <summary>
    /// A definition of a OPTIONS operation on this path.
    /// </summary>
    property Options: TOpenAPIOperation read GetOperationOptions;
    /// <summary>
    /// A definition of a HEAD operation on this path.
    /// </summary>
    property Head: TOpenAPIOperation read GetOperationHead;
    /// <summary>
    /// A definition of a PATCH operation on this path.
    /// </summary>
    property Patch: TOpenAPIOperation read GetOperationPatch;
    /// <summary>
    /// A definition of a TRACE operation on this path.
    /// </summary>
    property Trace: TOpenAPIOperation read GetOperationTrace;
    /// <summary>
    /// An alternative server array to service all operations in this path.
    /// </summary>
    property Servers: TOpenAPIServerList read GetServers;
    /// <summary>
    /// A list of parameters that are applicable for all the operations described under this path.
    /// These parameters can be overridden at the operation level, but cannot be removed there.
    /// The list MUST NOT include duplicated parameters. A unique parameter is defined by a combination of a name and location.
    /// The list can use the Reference Object to link to parameters that are defined at the OpenAPI Object's components/parameters.
    /// </summary>
    property Parameters: TOpenAPIParameterList read GetParameters;
  end;

  /// <summary>
  /// Describes a single API operation on a path.
  /// </summary>
  TOpenAPIOperation = class
  private
    FTags: TList<string>;
    FSummary: Nullable<string>;
    FDescription: Nullable<string>;
    FOperationId: string;
    FExternalDocs: TOpenAPIExternalDoc;
    FParameters: TOpenAPIParameterList;
    FRequestBody: TOpenAPIRequestBody;
// FCallbacks: TOpenAPICallbackMap;
    FResponses: TOpenAPIResponseMap;
    FDeprecated: Nullable<Boolean>;
    FSecurity: TOpenAPISecurityRequirement;
    FServers: TOpenAPIServerList;
    function GetParameters: TOpenAPIParameterList;
// function GetCallbacks: TOpenAPICallbackMap;
    function GetRequestBody: TOpenAPIRequestBody;
    function GetResponses: TOpenAPIResponseMap;
    function GetSecurity: TOpenAPISecurityRequirement;
    function GetServers: TOpenAPIServerList;
    function GetExternalDocs: TOpenAPIExternalDoc;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// A list of tags for API documentation control. Tags can be used for logical grouping of operations by resources or any other qualifier.
    /// </summary>
    property Tags: TList<string> read FTags write FTags;
    /// <summary>
    /// A short summary of what the operation does.
    /// </summary>
    property Summary: Nullable<string> read FSummary write FSummary;
    /// <summary>
    /// A verbose explanation of the operation behavior. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// Additional external documentation for this operation.
    /// </summary>
    property ExternalDocs: TOpenAPIExternalDoc read GetExternalDocs;
    /// <summary>
    /// Unique string used to identify the operation. The id MUST be unique among all operations described in the API.
    /// The operationId value is case-sensitive. Tools and libraries MAY use the operationId to uniquely identify an operation,
    /// therefore, it is RECOMMENDED to follow common programming naming conventions.
    /// </summary>
    property OperationId: string read FOperationId write FOperationId;
    /// <summary>
    /// A list of parameters that are applicable for this operation. If a parameter is already defined at the Path Item,
    /// the new definition will override it but can never remove it. The list MUST NOT include duplicated parameters.
    /// A unique parameter is defined by a combination of a name and location.
    /// The list can use the Reference Object to link to parameters that are defined at the OpenAPI Object’s components/parameters.
    /// </summary>
    property Parameters: TOpenAPIParameterList read GetParameters;
    /// <summary>
    /// The request body applicable for this operation.
    /// The requestBody is fully supported in HTTP methods where the HTTP 1.1 specification [RFC7231] has explicitly defined
    /// semantics for request bodies. In other cases where the HTTP spec is vague (such as [GET]section-4.3.1), [HEAD]section-4.3.2)
    /// and [DELETE]section-4.3.5)), requestBody is permitted but does not have well-defined semantics and SHOULD be avoided if possible.
    /// </summary>
    property RequestBody: TOpenAPIRequestBody read GetRequestBody;
    /// <summary>
    /// The list of possible responses as they are returned from executing this operation.
    /// </summary>
    property Responses: TOpenAPIResponseMap read GetResponses;
    /// <summary>
    /// A map of possible out-of band callbacks related to the parent operation. The key is a unique identifier for the Callback Object.
    /// Each value in the map is a Callback Object that describes a request that may be initiated by the API provider and the expected responses.
    /// </summary>
// property Callbacks: TOpenAPICallbackMap read GetCallbacks;
    /// <summary>
    /// Declares this operation to be deprecated. Consumers SHOULD refrain from usage of the declared operation. Default value is false.
    /// </summary>
    property &Deprecated: Nullable<Boolean> read FDeprecated write FDeprecated;
    /// <summary>
    /// A declaration of which security mechanisms can be used for this operation.
    /// The list of values includes alternative security requirement objects that can be used. Only one of the security requirement objects
    /// need to be satisfied to authorize a request. To make security optional, an empty security requirement ({}) can be included in the array.
    /// This definition overrides any declared top-level security. To remove a top-level security declaration, an empty array can be used.
    /// </summary>
    property Security: TOpenAPISecurityRequirement read GetSecurity;
    /// <summary>
    /// An alternative server array to service this operation. If an alternative server object is specified at the Path Item Object or Root level,
    /// it will be overridden by this value.
    /// </summary>
    property Servers: TOpenAPIServerList read GetServers;
  end;

  /// <summary>
  /// Allows referencing an external resource for extended documentation.
  /// </summary>
  TOpenAPIExternalDoc = class
  private
    FDescription: Nullable<string>;
    FUrl: string;
  public
    /// <summary>
    /// A description of the target documentation. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// REQUIRED. The URL for the target documentation. This MUST be in the form of a URL.
    /// </summary>
    property Url: string read FUrl write FUrl;
  end;

  /// <summary>
  /// Describes a single operation parameter.
  /// A unique parameter is defined by a combination of a name and location.
  /// </summary>
  TOpenAPIParameter = class
  private
    FName: string;
    FIn: TParamLocation;
    FDescription: Nullable<string>;
    FRequired: Boolean;
    FDeprecated: Nullable<Boolean>;
    FStyle: Nullable<string>;
    FExplode: Nullable<Boolean>;
    FAllowReserved: Nullable<Boolean>;
    FSchema: TOpenAPISchema;
    FExamples: TOpenAPIExampleMap;
    function GetExamples: TOpenAPIExampleMap;
    function GetSchema: TOpenAPISchema;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// REQUIRED. The name of the parameter. Parameter names are case sensitive.
    /// If in is "path", the name field MUST correspond to a template expression occurring within the path field in the Paths Object.
    /// If in is "header" and the name field is "Accept", "Content-Type" or "Authorization", the parameter definition SHALL be ignored.
    /// For all other cases, the name corresponds to the parameter name used by the in property.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    /// REQUIRED. The location of the parameter. Possible values are "query", "header", "path" or "cookie".
    /// </summary>
    property &In: TParamLocation read FIn write FIn;
    /// <summary>
    /// A brief description of the parameter. This could contain examples of use. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// Determines whether this parameter is mandatory. If the parameter location is "path", this property is REQUIRED and its value MUST be true.
    /// Otherwise, the property MAY be included and its default value is false.
    /// </summary>
    property Required: Boolean read FRequired write FRequired;
    /// <summary>
    /// Specifies that a parameter is deprecated and SHOULD be transitioned out of usage. Default value is false.
    /// </summary>
    property &Deprecated: Nullable<Boolean> read FDeprecated write FDeprecated;
    /// <summary>
    /// Describes how the parameter value will be serialized depending on the type of the parameter value.
    /// Default values (based on value of in): for query - form; for path - simple; for header - simple; for cookie - form.
    /// </summary>
    property Style: Nullable<string> read FStyle write FStyle;
    /// <summary>
    /// When this is true, parameter values of type array or object generate separate parameters for each value of the array or
    /// key-value pair of the map. For other types of parameters this property has no effect. When style is form, the default value is true.
    /// For all other styles, the default value is false.
    /// </summary>
    property Explode: Nullable<Boolean> read FExplode write FExplode;
    /// <summary>
    /// Determines whether the parameter value SHOULD allow reserved characters, as defined by [RFC3986] :/?#[]@!$&'()*+,;=
    /// to be included without percent-encoding. This property only applies to parameters with an in value of query. The default value is false.
    /// </summary>
    property AllowReserved: Nullable<Boolean> read FAllowReserved write FAllowReserved;
    /// <summary>
    /// The schema defining the type used for the parameter.
    /// </summary>
    property Schema: TOpenAPISchema read GetSchema;
    /// <summary>
    /// Examples of the parameter’s potential value. Each example SHOULD contain a value in the correct format as specified in
    /// the parameter encoding. The examples field is mutually exclusive of the example field. Furthermore, if referencing a
    /// schema that contains an example, the examples value SHALL override the example provided by the schema.
    /// </summary>
    property Examples: TOpenAPIExampleMap read GetExamples;
  end;

  /// <summary>
  /// Describes a single request body.
  /// </summary>
  TOpenAPIRequestBody = class
  private
    FDescription: Nullable<string>;
    FContent: TOpenAPIMediaTypeMap;
    FRequired: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// A brief description of the request body. This could contain examples of use. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// REQUIRED. The content of the request body. The key is a media type or media type range and the value describes it.
    /// For requests that match multiple keys, only the most specific key is applicable. e.g. text/plain overrides text/*
    /// </summary>
    property Content: TOpenAPIMediaTypeMap read FContent;
    /// <summary>
    /// Determines if the request body is required in the request. Defaults to false.
    /// </summary>
    property Required: Boolean read FRequired write FRequired;
  end;

  /// <summary>
  /// A container for the expected responses of an operation. The container maps a HTTP response code to the expected response.
  /// The documentation is not necessarily expected to cover all possible HTTP response codes because they may not be known in advance.
  /// However, documentation is expected to cover a successful operation response and any known errors.
  /// The default MAY be used as a default response object for all HTTP codes that are not covered individually by the Responses Object.
  /// The Responses Object MUST contain at least one response code, and if only one response code is provided it SHOULD be the response
  /// for a successful operation call.
  /// </summary>
  TOpenAPIResponse = class
  private
    FDescription: string;
    FHeaders: TOpenAPIHeaderMap;
    FContent: TOpenAPIMediaTypeMap;
    FLinks: TOpenAPILinkMap;
    function GetContent: TOpenAPIMediaTypeMap;
    function GetHeaders: TOpenAPIHeaderMap;
    function GetLinks: TOpenAPILinkMap;
  public
    constructor Create;
    destructor Destroy; override;

    /// <summary>
    /// REQUIRED. A description of the response. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: string read FDescription write FDescription;
    /// <summary>
    /// Maps a header name to its definition. [RFC7230] states header names are case insensitive.
    /// If a response header is defined with the name , it "Content-Type"SHALL be ignored.
    /// </summary>
    property Headers: TOpenAPIHeaderMap read GetHeaders;
    /// <summary>
    /// A map containing descriptions of potential response payloads. The key is a media type or [media type range]appendix-D) and the value
    /// describes it. For responses that match multiple keys, only the most specific key is applicable. e.g. text/plain overrides text/*
    /// </summary>
    property Content: TOpenAPIMediaTypeMap read GetContent;
    /// <summary>
    /// A map of operations links that can be followed from the response. The key of the map is a short name for the link,
    /// following the naming constraints of the names for Component Objects.
    /// </summary>
    property Links: TOpenAPILinkMap read GetLinks;
  end;

  /// <summary>
  /// Each Media Type Object provides schema and examples for the media type identified by its key.
  /// </summary>
  TOpenAPIMediaType = class
  private
    FSchema: TOpenAPISchema;
    FExamples: TOpenAPIExample;
    FEncoding: TOpenAPIEncodingMap;
    function GetEncoding: TOpenAPIEncodingMap;
    function GetExamples: TOpenAPIExample;
    function GetSchema: TOpenAPISchema;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// The schema defining the content of the request, response, or parameter.
    /// </summary>
    property Schema: TOpenAPISchema read GetSchema;
    /// <summary>
    /// Examples of the media type. Each example object SHOULD match the media type and specified schema if present.
    /// The examples field is mutually exclusive of the example field. Furthermore, if referencing a schema which contains an example,
    /// the examples value SHALL override the example provided by the schema.
    /// </summary>
    property Examples: TOpenAPIExample read GetExamples;
    /// <summary>
    /// A map between a property name and its encoding information. The key, being the property name, MUST exist in the schema as a property.
    /// The encoding object SHALL only apply to requestBody objects when the media type is multipart or application/x-www-form-urlencoded.
    /// </summary>
    property Encoding: TOpenAPIEncodingMap read GetEncoding;
  end;

  /// <summary>
  /// A single encoding definition applied to a single schema property.
  /// </summary>
  TOpenAPIEncoding = class
  private
    FContentType: string;
    FHeaders: TOpenAPIHeaderMap;
    FStyle: Nullable<string>;
    FExplode: Nullable<Boolean>;
    FAllowReserved: Nullable<Boolean>;
  public
    /// <summary>
    /// The Content-Type for encoding a specific property. Default value depends on the property type: for object - application/json;
    /// for array – the default is defined based on the inner type; for all other cases the default is application/octet-stream.
    /// The value can be a specific media type (e.g. application/json), a wildcard media type (e.g. image/*),
    /// or a comma-separated list of the two types.
    /// </summary>
    property ContentType: string read FContentType write FContentType;
    /// <summary>
    /// A map allowing additional information to be provided as headers, for example Content-Disposition.
    /// Content-Type is described separately and SHALL be ignored in this section. This property SHALL be ignored
    /// if the request body media type is not a multipart.
    /// </summary>
    property Headers: TOpenAPIHeaderMap read FHeaders write FHeaders;
    /// <summary>
    /// Describes how a specific property value will be serialized depending on its type. See Parameter Object for details on the style property.
    /// The behavior follows the same values as query parameters, including default values.
    /// This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded or multipart/form-data.
    /// If a value is explicitly defined, then the value of contentType (implicit or explicit) SHALL be ignored.
    /// </summary>
    property Style: Nullable<string> read FStyle write FStyle;
    /// <summary>
    /// When this is true, property values of type array or object generate separate parameters for each value of the array,
    /// or key-value-pair of the map. For other types of properties this property has no effect. When style is form, the default value is true.
    /// For all other styles, the default value is false. This property SHALL be ignored if the request body media type is not
    /// application/x-www-form-urlencoded or multipart/form-data. If a value is explicitly defined,
    /// then the value of contentType (implicit or explicit) SHALL be ignored.
    /// </summary>
    property Explode: Nullable<Boolean> read FExplode write FExplode;
    /// <summary>
    /// Determines whether the parameter value SHOULD allow reserved characters, as defined by [RFC3986] :/?#[]@!$&'()*+,;=
    /// to be included without percent-encoding. The default value is false. This property SHALL be ignored
    /// if the request body media type is not application/x-www-form-urlencoded or multipart/form-data.
    /// If a value is explicitly defined, then the value of contentType (implicit or explicit) SHALL be ignored.
    /// </summary>
    property AllowReserved: Nullable<Boolean> read FAllowReserved write FAllowReserved;
  end;

  TOpenAPIExample = class
  private
    FSummary: Nullable<string>;
    FDescription: Nullable<string>;
    FExternalValue: Nullable<string>;
  public
    /// <summary>
    /// Short description for the example.
    /// </summary>
    property Summary: Nullable<string> read FSummary write FSummary;
    /// <summary>
    /// Long description for the example. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// A URI that points to the literal example. This provides the capability to reference examples that cannot easily be included
    /// in JSON or YAML documents. The value field and externalValue field are mutually exclusive.
    /// See the rules for resolving Relative References.
    /// </summary>
    property ExternalValue: Nullable<string> read FExternalValue write FExternalValue;
  end;

  TOpenAPIHeader = class
  private
    FDescription: Nullable<string>;
    FRequired: Boolean;
    FDeprecated: Nullable<Boolean>;
    FStyle: Nullable<string>;
    FExplode: Nullable<Boolean>;
    FAllowReserved: Nullable<Boolean>;
    FSchema: TOpenAPISchema;
    FExamples: TOpenAPIExampleMap;
    function GetExamples: TOpenAPIExampleMap;
    function GetSchema: TOpenAPISchema;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// A brief description of the header. This could contain examples of use. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// Determines whether this header is mandatory.
    /// </summary>
    property Required: Boolean read FRequired write FRequired;
    /// <summary>
    /// Specifies that a header is deprecated and SHOULD be transitioned out of usage. Default value is false.
    /// </summary>
    property &Deprecated: Nullable<Boolean> read FDeprecated write FDeprecated;
    /// <summary>
    /// Describes how the header value will be serialized depending on the type of the parameter value.
    /// </summary>
    property Style: Nullable<string> read FStyle write FStyle;
    /// <summary>
    /// When this is true, header values of type array or object generate separate parameters for each value of the array or
    /// key-value pair of the map. For other types of parameters this property has no effect. When style is form, the default value is true.
    /// For all other styles, the default value is false.
    /// </summary>
    property Explode: Nullable<Boolean> read FExplode write FExplode;
    /// <summary>
    /// Determines whether the header value SHOULD allow reserved characters, as defined by [RFC3986] :/?#[]@!$&'()*+,;=
    /// to be included without percent-encoding. This property only applies to parameters with an in value of query. The default value is false.
    /// </summary>
    property AllowReserved: Nullable<Boolean> read FAllowReserved write FAllowReserved;
    /// <summary>
    /// The schema defining the type used for the header.
    /// </summary>
    property Schema: TOpenAPISchema read GetSchema;
    /// <summary>
    /// Examples of the header’s potential value. Each example SHOULD contain a value in the correct format as specified in
    /// the header encoding. The examples field is mutually exclusive of the example field. Furthermore, if referencing a
    /// schema that contains an example, the examples value SHALL override the example provided by the schema.
    /// </summary>
    property Examples: TOpenAPIExampleMap read GetExamples;
  end;

  TOpenAPILink = class
  private
    FOperationId: Nullable<string>;
    FOperationRef: Nullable<string>;
    FDescription: Nullable<string>;
    FServer: TOpenAPIServer;
    FRequestBody: Nullable<string>;
    FParameters: Nullable<string>;
    function GetServer: TOpenAPIServer;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// A relative or absolute URI reference to an OAS operation. This field is mutually exclusive of the field,
    /// and operationIdMUST point to an Operation Object. Relative values operationRefMAY be used to locate an existing Operation Object
    /// in the OpenAPI definition. See the rules for resolving Relative References.
    /// </summary>
    property OperationRef: Nullable<string> read FOperationRef write FOperationRef;
    /// <summary>
    /// The name of an existing, resolvable OAS operation, as defined with a unique.
    /// This field is mutually exclusive of the field.operationIdoperationRef
    /// </summary>
    property OperationId: Nullable<string> read FOperationId write FOperationId;
    /// <summary>
    /// A map representing parameters to pass to an operation as specified with or identified via.
    /// The key is the parameter name to be used, whereas the value can be a constant or an expression to be evaluated and passed
    /// to the linked operation. The parameter name can be qualified using the parameter location for operations that use the
    /// same parameter name in different locations (e.g. path.id).operationIdoperationRef[{in}.]{name}
    /// </summary>
    property Parameters: Nullable<string> read FParameters write FParameters;
    /// <summary>
    /// A literal value or {expression} to use as a request body when calling the target operation.
    /// </summary>
    property RequestBody: Nullable<string> read FRequestBody write FRequestBody;
    /// <summary>
    /// A description of the link. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// A server object to be used by the target operation.
    /// </summary>
    property Server: TOpenAPIServer read GetServer;
  end;

implementation

uses
  System.SysUtils;

{ TOpenAPIPathItem }

constructor TOpenAPIPathItem.Create;
begin
  inherited Create;
  FOperationGet := nil;
  FOperationPut := nil;
  FOperationPost := nil;
  FOperationDelete := nil;
  FOperationOptions := nil;
  FOperationHead := nil;
  FOperationPatch := nil;
  FOperationTrace := nil;
  FServers := nil;
  FParameters := nil;
end;

destructor TOpenAPIPathItem.Destroy;
begin
  if Assigned(FOperationGet) then
    FreeAndNil(FOperationGet);
  if Assigned(FOperationPut) then
    FreeAndNil(FOperationPut);
  if Assigned(FOperationPost) then
    FreeAndNil(FOperationPost);
  if Assigned(FOperationDelete) then
    FreeAndNil(FOperationDelete);
  if Assigned(FOperationOptions) then
    FreeAndNil(FOperationOptions);
  if Assigned(FOperationHead) then
    FreeAndNil(FOperationHead);
  if Assigned(FOperationPatch) then
    FreeAndNil(FOperationPatch);
  if Assigned(FOperationTrace) then
    FreeAndNil(FOperationTrace);
  if Assigned(FServers) then
    FreeAndNil(FServers);
  if Assigned(FParameters) then
    FreeAndNil(FParameters);

  inherited Destroy;
end;

function TOpenAPIPathItem.GetOperationDelete: TOpenAPIOperation;
begin
  if not Assigned(FOperationDelete) then
    FOperationDelete := TOpenAPIOperation.Create;
  Result := FOperationDelete;
end;

function TOpenAPIPathItem.GetOperationGet: TOpenAPIOperation;
begin
  if not Assigned(FOperationGet) then
    FOperationGet := TOpenAPIOperation.Create;
  Result := FOperationGet;
end;

function TOpenAPIPathItem.GetOperationHead: TOpenAPIOperation;
begin
  if not Assigned(FOperationHead) then
    FOperationHead := TOpenAPIOperation.Create;
  Result := FOperationHead;
end;

function TOpenAPIPathItem.GetOperationOptions: TOpenAPIOperation;
begin
  if not Assigned(FOperationOptions) then
    FOperationOptions := TOpenAPIOperation.Create;
  Result := FOperationOptions;
end;

function TOpenAPIPathItem.GetOperationPatch: TOpenAPIOperation;
begin
  if not Assigned(FOperationPatch) then
    FOperationPatch := TOpenAPIOperation.Create;
  Result := FOperationPatch;
end;

function TOpenAPIPathItem.GetOperationPost: TOpenAPIOperation;
begin
  if not Assigned(FOperationPost) then
    FOperationPost := TOpenAPIOperation.Create;
  Result := FOperationPost;
end;

function TOpenAPIPathItem.GetOperationPut: TOpenAPIOperation;
begin
  if not Assigned(FOperationPut) then
    FOperationPut := TOpenAPIOperation.Create;
  Result := FOperationPut;
end;

function TOpenAPIPathItem.GetOperationTrace: TOpenAPIOperation;
begin
  if not Assigned(FOperationTrace) then
    FOperationTrace := TOpenAPIOperation.Create;
  Result := FOperationTrace;
end;

function TOpenAPIPathItem.GetParameters: TOpenAPIParameterList;
begin
  if not Assigned(FParameters) then
    FParameters := TOpenAPIParameterList.Create;
  Result := FParameters;
end;

function TOpenAPIPathItem.GetServers: TOpenAPIServerList;
begin
  if not Assigned(FServers) then
    FServers := TOpenAPIServerList.Create;
  Result := FServers;
end;

{ TOpenAPIOperation }

constructor TOpenAPIOperation.Create;
begin
  inherited Create;
  FExternalDocs := nil;
  FParameters := nil;
  FRequestBody := nil;
// FCallbacks := nil;
  FResponses := nil;
  FSecurity := nil;
  FServers := nil;
end;

destructor TOpenAPIOperation.Destroy;
begin
  if Assigned(FExternalDocs) then
    FreeAndNil(FExternalDocs);
  if Assigned(FParameters) then
    FreeAndNil(FParameters);
  if Assigned(FRequestBody) then
    FreeAndNil(FRequestBody);
// if Assigned(FCallbacks) then
// FreeAndNil(FCallbacks);
  if Assigned(FResponses) then
    FreeAndNil(FResponses);
  if Assigned(FSecurity) then
    FreeAndNil(FSecurity);
  if Assigned(FServers) then
    FreeAndNil(FServers);

  inherited Destroy;
end;

// function TOpenAPIOperation.GetCallbacks: TOpenAPICallbackMap;
// begin
//
// end;

function TOpenAPIOperation.GetExternalDocs: TOpenAPIExternalDoc;
begin
  if not Assigned(FExternalDocs) then
    FExternalDocs := TOpenAPIExternalDoc.Create;
  Result := FExternalDocs;
end;

function TOpenAPIOperation.GetParameters: TOpenAPIParameterList;
begin
  if not Assigned(FParameters) then
    FParameters := TOpenAPIParameterList.Create;
  Result := FParameters;
end;

function TOpenAPIOperation.GetRequestBody: TOpenAPIRequestBody;
begin
  if not Assigned(FRequestBody) then
    FRequestBody := TOpenAPIRequestBody.Create;
  Result := FRequestBody;
end;

function TOpenAPIOperation.GetResponses: TOpenAPIResponseMap;
begin
  if not Assigned(FResponses) then
    FResponses := TOpenAPIResponseMap.Create;
  Result := FResponses;
end;

function TOpenAPIOperation.GetSecurity: TOpenAPISecurityRequirement;
begin
  if not Assigned(FSecurity) then
    FSecurity := TOpenAPISecurityRequirement.Create;
  Result := FSecurity;
end;

function TOpenAPIOperation.GetServers: TOpenAPIServerList;
begin
  if not Assigned(FServers) then
    FServers := TOpenAPIServerList.Create;
  Result := FServers;
end;

{ TOpenAPIRequestBody }

constructor TOpenAPIRequestBody.Create;
begin
  inherited Create;
  FContent := TOpenAPIMediaTypeMap.Create;
end;

destructor TOpenAPIRequestBody.Destroy;
begin
  FreeAndNil(FContent);
  inherited Destroy;
end;

{ TOpenAPIParameter }

constructor TOpenAPIParameter.Create;
begin
  inherited Create;
  FSchema := nil;
  FExamples := nil;
end;

destructor TOpenAPIParameter.Destroy;
begin
  if Assigned(FSchema) then
    FreeAndNil(FSchema);
  if Assigned(FExamples) then
    FreeAndNil(FExamples);
  inherited Destroy;
end;

function TOpenAPIParameter.GetExamples: TOpenAPIExampleMap;
begin
  if not Assigned(FExamples) then
    FExamples := TOpenAPIExampleMap.Create;
  Result := FExamples;
end;

function TOpenAPIParameter.GetSchema: TOpenAPISchema;
begin
  if not Assigned(FSchema) then
    FSchema := TOpenAPISchema.Create;
  Result := FSchema;
end;

{ TOpenAPIMediaType }

constructor TOpenAPIMediaType.Create;
begin
  inherited Create;
  FSchema := nil;
  FExamples := nil;
  FEncoding := nil;
end;

destructor TOpenAPIMediaType.Destroy;
begin
  if Assigned(FSchema) then
    FreeAndNil(FSchema);
  if Assigned(FExamples) then
    FreeAndNil(FExamples);
  if Assigned(FEncoding) then
    FreeAndNil(FEncoding);

  inherited Destroy;
end;

function TOpenAPIMediaType.GetEncoding: TOpenAPIEncodingMap;
begin
  if not Assigned(FEncoding) then
    FEncoding := TOpenAPIEncodingMap.Create;
  Result := FEncoding;
end;

function TOpenAPIMediaType.GetExamples: TOpenAPIExample;
begin
  if not Assigned(FExamples) then
    FExamples := TOpenAPIExample.Create;
  Result := FExamples;
end;

function TOpenAPIMediaType.GetSchema: TOpenAPISchema;
begin
  if not Assigned(FSchema) then
    FSchema := TOpenAPISchema.Create;
  Result := FSchema;
end;

{ TOpenAPIHeader }

constructor TOpenAPIHeader.Create;
begin
  inherited Create;
  FSchema := nil;
  FExamples := nil;
end;

destructor TOpenAPIHeader.Destroy;
begin
  if Assigned(FSchema) then
    FreeAndNil(FSchema);
  if Assigned(FExamples) then
    FreeAndNil(FExamples);
  inherited Destroy;
end;

function TOpenAPIHeader.GetExamples: TOpenAPIExampleMap;
begin
  if not Assigned(FExamples) then
    FExamples := TOpenAPIExampleMap.Create;
  Result := FExamples;
end;

function TOpenAPIHeader.GetSchema: TOpenAPISchema;
begin
  if not Assigned(FSchema) then
    FSchema := TOpenAPISchema.Create;
  Result := FSchema;
end;

{ TOpenAPIResponse }

constructor TOpenAPIResponse.Create;
begin
  inherited Create;
  FHeaders := nil;
  FContent := nil;
  FLinks := nil;
end;

destructor TOpenAPIResponse.Destroy;
begin
  if Assigned(FHeaders) then
    FreeAndNil(FHeaders);
  if Assigned(FContent) then
    FreeAndNil(FContent);
  if Assigned(FLinks) then
    FreeAndNil(FLinks);
  inherited Destroy;
end;

function TOpenAPIResponse.GetContent: TOpenAPIMediaTypeMap;
begin
  if not Assigned(FContent) then
    FContent := TOpenAPIMediaTypeMap.Create;
  Result := FContent;
end;

function TOpenAPIResponse.GetHeaders: TOpenAPIHeaderMap;
begin
  if not Assigned(FHeaders) then
    FHeaders := TOpenAPIHeaderMap.Create;
  Result := FHeaders;
end;

function TOpenAPIResponse.GetLinks: TOpenAPILinkMap;
begin
  if not Assigned(FLinks) then
    FLinks := TOpenAPILinkMap.Create;
  Result := FLinks;
end;

{ TOpenAPILink }

constructor TOpenAPILink.Create;
begin
  inherited Create;
  FServer := nil;
end;

destructor TOpenAPILink.Destroy;
begin
  if Assigned(FServer) then
    FreeAndNil(FServer);
  inherited Destroy;
end;

function TOpenAPILink.GetServer: TOpenAPIServer;
begin
  if not Assigned(FServer) then
    FServer := TOpenAPIServer.Create;
  Result := FServer;
end;

end.
