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

unit OpenAPI.Schema;

interface

uses
  System.Generics.Collections,
  OpenAPI.Types;

type
  TOpenAPISchema = class;
  TOpenAPISchemaMap = class(TOpenAPIObjectMap<TOpenAPISchema>);

  TOpenAPISchema = class
  private
    [OpenAPIField('type')]
    FType: string;

    [OpenAPIField('format')]
    FFormat: Nullable<string>;

    [OpenAPIField('pattern')]
    FPattern: Nullable<string>;

    [OpenAPIField('description')]
    FDescription: Nullable<string>;

    [OpenAPIField('maxLength')]
    FMaxLength: Nullable<Integer>;

    [OpenAPIField('minLength')]
    FMinLength: Nullable<Integer>;

    [OpenAPIField('multipleOf')]
    FMultipleOf: Nullable<Double>;

    [OpenAPIField('minimum')]
    FMinimum: Nullable<Double>;

    [OpenAPIField('maximum')]
    FMaximum: Nullable<Double>;

    [OpenAPIField('exclusiveMinimum')]
    FExclusiveMinimum: Nullable<Boolean>;

    [OpenAPIField('exclusiveMaximum')]
    FExclusiveMaximum: Nullable<Boolean>;

    [OpenAPIField('properties')]
    FProperties: TOpenAPISchemaMap;

    [OpenAPIField('aditionalProperties')]
    FAditionalProperties: Nullable<Boolean>;

    [OpenAPIField('required')]
    FRequiredProperties: TList<string>;

    function GetProperties: TOpenAPISchemaMap;
    function GetRequiredProperties: TList<string>;
  public
    constructor Create;
    destructor Destroy; override;

    property &Type: string read FType write FType;
    property Format: Nullable<string> read FFormat write FFormat;
    property Description: Nullable<string> read FDescription write FDescription;
    property MinLength: Nullable<Integer> read FMinLength write FMinLength;
    property MaxLength: Nullable<Integer> read FMaxLength write FMaxLength;
    property Pattern: Nullable<string> read FPattern write FPattern;
    property Minimum: Nullable<Double> read FMinimum write FMinimum;
    property Maximum: Nullable<Double> read FMaximum write FMaximum;
    property ExclusiveMinimum: Nullable<Boolean> read FExclusiveMinimum write FExclusiveMinimum;
    property ExclusiveMaximum: Nullable<Boolean> read FExclusiveMaximum write FExclusiveMaximum;
    property MultipleOf: Nullable<Double> read FMultipleOf write FMultipleOf;
    property Properties: TOpenAPISchemaMap read GetProperties;
    property AditionalProperties: Nullable<Boolean> read FAditionalProperties write FAditionalProperties;
    property RequiredProperties: TList<string> read GetRequiredProperties;
  end;

implementation

uses
  System.SysUtils;

{ TOpenAPISchema }

constructor TOpenAPISchema.Create;
begin
  inherited Create;
  FProperties := nil;
  FRequiredProperties := nil;
end;

destructor TOpenAPISchema.Destroy;
begin
  if Assigned(FProperties) then
    FreeAndNil(FProperties);
  if Assigned(FRequiredProperties) then
    FreeAndNil(FRequiredProperties);

  inherited Destroy;
end;

function TOpenAPISchema.GetProperties: TOpenAPISchemaMap;
begin
  if not Assigned(FProperties) then
    FProperties := TOpenAPISchemaMap.Create;
  Result := FProperties;
end;

function TOpenAPISchema.GetRequiredProperties: TList<string>;
begin
  if not Assigned(FRequiredProperties) then
    FRequiredProperties := TList<string>.Create;
  Result := FRequiredProperties;
end;

end.
