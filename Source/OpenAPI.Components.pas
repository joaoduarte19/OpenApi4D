// ***************************************************************************
//
// OpenAPI Generator for Delphi
//
// Copyright (c) 2021 João Antônio Duarte
//
// https://github.com/joaoduarte19/OpenApi4D
//
// ***************************************************************************
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ***************************************************************************

unit OpenAPI.Components;

interface

uses
  OpenAPI.Types,
  OpenAPI.Schema,
  OpenAPI.Path,
  OpenAPI.Security;

type
  /// <summary>
  /// Holds a set of reusable objects for different aspects of the OAS.
  /// All objects defined within the components object will have no effect on the API unless they are explicitly
  /// referenced from properties outside the components object.
  /// </summary>
  TOpenAPIComponents = class
  private
    [OpenAPIField('schemas')]
    FSchemas: TOpenAPISchemaMap;

    [OpenAPIField('responses')]
    FResponses: TOpenAPIResponseMap;

    [OpenAPIField('parameters')]
    FParameters: TOpenAPIParameterMap;

    [OpenAPIField('examples')]
    FExamples: TOpenAPIExampleMap;

    [OpenAPIField('requestBodies')]
    FRequestBodies: TOpenAPIRequestBodyMap;

    [OpenAPIField('headers')]
    FHeaders: TOpenAPIHeaderMap;

    [OpenAPIField('securitySchemes')]
    FSecuritySchemes: TOpenAPISecurityMap;

    [OpenAPIField('links')]
    FLinks: TOpenAPILinkMap;

// [OpenAPIField('callbacks')]
// FCallbacks: TOpenAPICallbackMap;

    [OpenAPIField('pathItems')]
    FPathItems: TOpenAPIPathItemMap;

// function GetCallbacks: TOpenAPICallbackMap;
    function GetExamples: TOpenAPIExampleMap;
    function GetHeaders: TOpenAPIHeaderMap;
    function GetLinks: TOpenAPILinkMap;
    function GetParameters: TOpenAPIParameterMap;
    function GetPathItems: TOpenAPIPathItemMap;
    function GetRequestBodies: TOpenAPIRequestBodyMap;
    function GetResponses: TOpenAPIResponseMap;
    function GetSchemas: TOpenAPISchemaMap;
    function GetSecuritySchemes: TOpenAPISecurityMap;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// An object to hold reusable Schema Objects.
    /// </summary>
    property Schemas: TOpenAPISchemaMap read GetSchemas;
    /// <summary>
    /// An object to hold reusable Response Objects.
    /// </summary>
    property Responses: TOpenAPIResponseMap read GetResponses;
    /// <summary>
    /// An object to hold reusable Parameter Objects.
    /// </summary>
    property Parameters: TOpenAPIParameterMap read GetParameters;
    /// <summary>
    /// An object to hold reusable Example Objects.
    /// </summary>
    property Examples: TOpenAPIExampleMap read GetExamples;
    /// <summary>
    /// An object to hold reusable Request Body Objects.
    /// </summary>
    property RequestBodies: TOpenAPIRequestBodyMap read GetRequestBodies;
    /// <summary>
    /// An object to hold reusable Header Objects.
    /// </summary>
    property Headers: TOpenAPIHeaderMap read GetHeaders;
    /// <summary>
    /// An object to hold reusable Security Scheme Objects.
    /// </summary>
    property SecuritySchemes: TOpenAPISecurityMap read GetSecuritySchemes;
    /// <summary>
    /// An object to hold reusable Link Objects.
    /// </summary>
    property Links: TOpenAPILinkMap read GetLinks;
// /// <summary>
// /// An object to hold reusable Callback Objects.
// /// </summary>
// property Callbacks: TOpenAPICallbackMap read GetCallbacks;
    /// <summary>
    /// An object to hold reusable Path Item Object.
    /// </summary>
    property PathItems: TOpenAPIPathItemMap read GetPathItems;
  end;

implementation

uses
  System.SysUtils;

{ TOpenAPIComponents }

constructor TOpenAPIComponents.Create;
begin
  inherited Create;

  FSchemas := nil;
  FResponses := nil;
  FParameters := nil;
  FExamples := nil;
  FRequestBodies := nil;
  FHeaders := nil;
  FSecuritySchemes := nil;
  FLinks := nil;
// FCallbacks := nil;
  FPathItems := nil;
end;

destructor TOpenAPIComponents.Destroy;
begin
  if Assigned(FSchemas) then
    FreeAndNil(FSchemas);
  if Assigned(FResponses) then
    FreeAndNil(FResponses);
  if Assigned(FParameters) then
    FreeAndNil(FParameters);
  if Assigned(FExamples) then
    FreeAndNil(FExamples);
  if Assigned(FRequestBodies) then
    FreeAndNil(FRequestBodies);
  if Assigned(FHeaders) then
    FreeAndNil(FHeaders);
  if Assigned(FSecuritySchemes) then
    FreeAndNil(FSecuritySchemes);
  if Assigned(FLinks) then
    FreeAndNil(FLinks);
// if Assigned(FCallbacks) then
// FreeAndNil(FCallbacks);
  if Assigned(FPathItems) then
    FreeAndNil(FPathItems);

  inherited Destroy;
end;

// function TOpenAPIComponents.GetCallbacks: TOpenAPICallbackMap;
// begin
// if not Assigned(FCallbacks) then
// FCallbacks := TOpenAPICallbackMap.Create;
// Result := FCallbacks;
// end;

function TOpenAPIComponents.GetExamples: TOpenAPIExampleMap;
begin
  if not Assigned(FExamples) then
    FExamples := TOpenAPIExampleMap.Create;
  Result := FExamples;
end;

function TOpenAPIComponents.GetHeaders: TOpenAPIHeaderMap;
begin
  if not Assigned(FHeaders) then
    FHeaders := TOpenAPIHeaderMap.Create;
  Result := FHeaders;
end;

function TOpenAPIComponents.GetLinks: TOpenAPILinkMap;
begin
  if not Assigned(FLinks) then
    FLinks := TOpenAPILinkMap.Create;
  Result := FLinks;
end;

function TOpenAPIComponents.GetParameters: TOpenAPIParameterMap;
begin
  if not Assigned(FParameters) then
    FParameters := TOpenAPIParameterMap.Create;
  Result := FParameters;
end;

function TOpenAPIComponents.GetPathItems: TOpenAPIPathItemMap;
begin
  if not Assigned(FPathItems) then
    FPathItems := TOpenAPIPathItemMap.Create;
  Result := FPathItems;
end;

function TOpenAPIComponents.GetRequestBodies: TOpenAPIRequestBodyMap;
begin
  if not Assigned(FRequestBodies) then
    FRequestBodies := TOpenAPIRequestBodyMap.Create;
  Result := FRequestBodies;
end;

function TOpenAPIComponents.GetResponses: TOpenAPIResponseMap;
begin
  if not Assigned(FResponses) then
    FResponses := TOpenAPIResponseMap.Create;
  Result := FResponses;
end;

function TOpenAPIComponents.GetSchemas: TOpenAPISchemaMap;
begin
  if not Assigned(FSchemas) then
    FSchemas := TOpenAPISchemaMap.Create;
  Result := FSchemas;
end;

function TOpenAPIComponents.GetSecuritySchemes: TOpenAPISecurityMap;
begin
  if not Assigned(FSecuritySchemes) then
    FSecuritySchemes := TOpenAPISecurityMap.Create;
  Result := FSecuritySchemes;
end;

end.
