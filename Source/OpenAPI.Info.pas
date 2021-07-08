unit OpenAPI.Info;

interface

uses
  OpenAPI.Types;

type
  TOpenAPIContact = class;
  TOpenAPILicense = class;

  /// <summary>
  /// The object provides metadata about the API.
  /// The metadata MAY be used by the clients if needed,
  /// and MAY be presented in editing or documentation generation tools for convenience.
  /// </summary>
  TOpenAPIInfo = class
  private
    FTitle: string;
    FSummary: Nullable<string>;
    FDescription: Nullable<string>;
    FTermsOfService: Nullable<string>;
    FContact: TOpenAPIContact;
    FLicense: TOpenAPILicense;
    FVersion: string;
    function GetContact: TOpenAPIContact;
    function GetLicense: TOpenAPILicense;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// REQUIRED. The title of the API.
    /// </summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// A short summary of the API.
    /// </summary>
    property Summary: Nullable<string> read FSummary write FSummary;
    /// <summary>
    /// A description of the API. CommonMark syntax MAY be used for rich text representation.
    /// </summary>
    property Description: Nullable<string> read FDescription write FDescription;
    /// <summary>
    /// A URL to the Terms of Service for the API. This MUST be in the form of a URL.
    /// </summary>
    property TermsOfService: Nullable<string> read FTermsOfService write FTermsOfService;
    /// <summary>
    /// The contact information for the exposed API.
    /// </summary>
    property Contact: TOpenAPIContact read GetContact;
    /// <summary>
    /// The license information for the exposed API.
    /// </summary>
    property License: TOpenAPILicense read GetLicense;
    /// <summary>
    /// REQUIRED. The version of the OpenAPI document (which is distinct from the OpenAPI Specification version or the API implementation version).
    /// </summary>
    property Version: string read FVersion write FVersion;
  end;

  /// <summary>
  /// Contact information for the exposed API.
  /// </summary>
  TOpenAPIContact = class
  private
    FName: Nullable<string>;
    FUrl: Nullable<string>;
    FEMail: Nullable<string>;
  public
    /// <summary>
    /// The identifying name of the contact person/organization.
    /// </summary>
    property Name: Nullable<string> read FName write FName;
    /// <summary>
    /// The URL pointing to the contact information. This MUST be in the form of a URL.
    /// </summary>
    property Url: Nullable<string> read FUrl write FUrl;
    /// <summary>
    /// The email address of the contact person/organization. This MUST be in the form of an email address.
    /// </summary>
    property EMail: Nullable<string> read FEMail write FEMail;
  end;

  /// <summary>
  /// License information for the exposed API.
  /// </summary>
  TOpenAPILicense = class
  private
    FName: string;
    FIdentifier: Nullable<string>;
    FUrl: Nullable<string>;
  public
    /// <summary>
    /// REQUIRED. The license name used for the API.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    /// An SPDX license expression for the API. The identifier field is mutually exclusive of the url field.
    /// </summary>
    property Identifier: Nullable<string> read FIdentifier write FIdentifier;
    /// <summary>
    /// A URL to the license used for the API. This MUST be in the form of a URL. The url field is mutually exclusive of the identifier field.
    /// </summary>
    property Url: Nullable<string> read FUrl write FUrl;
  end;

implementation

uses
  System.SysUtils;

{ TOpenAPIInfo }

constructor TOpenAPIInfo.Create;
begin
  inherited Create;
  FContact := nil;
  FLicense := nil;
end;

destructor TOpenAPIInfo.Destroy;
begin
  if Assigned(FContact) then
    FreeAndNil(FContact);
  if Assigned(FLicense) then
    FreeAndNil(FLicense);
  inherited Destroy;
end;

function TOpenAPIInfo.GetContact: TOpenAPIContact;
begin
  if not Assigned(FContact) then
    FContact := TOpenAPIContact.Create;

  Result := FContact;
end;

function TOpenAPIInfo.GetLicense: TOpenAPILicense;
begin
  if not Assigned(FLicense) then
    FLicense := TOpenAPILicense.Create;

  Result := FLicense;
end;

end.
