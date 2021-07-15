unit OpenAPI.Serializer;

interface

uses
  System.SysUtils,
  System.Rtti,
  System.JSON,
  System.TypInfo;

type
  TOpenAPISerializer = class
  private
    class var FRttiContext: TRttiContext;

    function TryGetOpenAPIField(const AMember: TRttiMember; out AOpenAPIFieldName: string): Boolean;
    procedure ObjectToJsonObject(const AObject: TObject; const AJsonObject: TJSONObject);
    procedure TValueToJsonObjectField(const AValue: TValue; const AJsonObject: TJSONObject; const AFieldName: string);
    procedure NullableValueToJSONObjetField(const AValue: TValue; const AJsonObject: TJSONObject; const AFieldName: string);
    function ObjectToJsonValue(const AObject: TObject): TJSONValue;
    procedure OpenAPIObjecTMapToJSONObject(const AObject; const AJsonObject: TJSONObject);
    function IsOpenAPIObjectMap(const AObject: TObject): Boolean;
    function IsObjectList(const AObject: TObject): Boolean;
  public
    class constructor Create;
    class destructor Destroy;

    function Serialize(const AOpenAPIDocument: TObject): string;
  end;

implementation

uses
  OpenAPI.Types,
  System.DateUtils, System.Generics.Collections;

{ TOpenAPISerializer }

class constructor TOpenAPISerializer.Create;
begin
  FRttiContext := TRttiContext.Create;
end;

class destructor TOpenAPISerializer.Destroy;
begin
  FRttiContext.Free;
end;

procedure TOpenAPISerializer.NullableValueToJSONObjetField(const AValue: TValue; const AJsonObject: TJSONObject; const AFieldName: string);
begin
  if AValue.TypeInfo = TypeInfo(Nullable<string>) then
  begin
    if AValue.AsType < Nullable < string >>.HasValue then
      AJsonObject.AddPair(AFieldName, AValue.AsType < Nullable < string >>.Value)
  end
  else if AValue.TypeInfo = TypeInfo(Nullable<Boolean>) then
  begin
    if AValue.AsType < Nullable < Boolean >>.HasValue then
      AJsonObject.AddPair(AFieldName, TJSONBool.Create(AValue.AsType < Nullable < Boolean >>.Value))
  end
  else if AValue.TypeInfo = TypeInfo(Nullable<Integer>) then
  begin
    if AValue.AsType < Nullable < Integer >>.HasValue then
      AJsonObject.AddPair(AFieldName, TJSONNumber.Create(AValue.AsType < Nullable < Integer >>.Value))
  end
  else if AValue.TypeInfo = TypeInfo(Nullable<Double>) then
  begin
    if AValue.AsType < Nullable < Double >>.HasValue then
      AJsonObject.AddPair(AFieldName, TJSONNumber.Create(AValue.AsType < Nullable < Double >>.Value))
  end
end;

function TOpenAPISerializer.TryGetOpenAPIField(const AMember: TRttiMember; out AOpenAPIFieldName: string): Boolean;
var
  LAttrs: TArray<TCustomAttribute>;
  LAttr: TCustomAttribute;
begin
  Result := False;
  AOpenAPIFieldName := '';
  LAttrs := AMember.GetAttributes;
  if Length(LAttrs) = 0 then
    Exit(False);
  for LAttr in LAttrs do
  begin
    if LAttr is OpenAPIFieldAttribute then
    begin
      AOpenAPIFieldName := OpenAPIFieldAttribute(LAttr).FieldName;
      Exit(True);
    end;
  end;
end;

procedure TOpenAPISerializer.TValueToJsonObjectField(const AValue: TValue; const AJsonObject: TJSONObject; const AFieldName: string);
var
  LChildObject: TObject;
  LJsonValue: TJSONValue;
begin
  if AValue.IsEmpty then
    Exit;

  case AValue.Kind of
    tkInteger:
      AJsonObject.AddPair(AFieldName, TJSONNumber.Create(AValue.AsInteger));

    tkInt64:
      AJsonObject.AddPair(AFieldName, TJSONNumber.Create(AValue.AsInt64));

    tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
      AJsonObject.AddPair(AFieldName, AValue.AsString);

    tkFloat:
      begin
        if AValue.AsExtended = 0 then
          AJsonObject.AddPair(AFieldName, TJSONNull.Create)
        else if (AValue.TypeInfo = System.TypeInfo(TDateTime)) then
          AJsonObject.AddPair(AFieldName, DateToISO8601(AValue.AsExtended))
        else if (AValue.TypeInfo = System.TypeInfo(TDate)) then
          AJsonObject.AddPair(AFieldName, FormatDateTime('yyyy-mm-dd', AValue.AsExtended))
        else if (AValue.TypeInfo = System.TypeInfo(TTime)) then
          AJsonObject.AddPair(AFieldName, FormatDateTime('hh:nn:ss', AValue.AsExtended))
        else
          AJsonObject.AddPair(AFieldName, TJSONNumber.Create(AValue.AsExtended));
      end;
    tkEnumeration:
      ;
    tkClass:
      begin
        LChildObject := AValue.AsObject;
        LJsonValue := ObjectToJsonValue(LChildObject);
        if Assigned(LJsonValue) then
          AJsonObject.AddPair(AFieldName, LJsonValue);
      end;
    tkArray:
      ;
    tkRecord:
      NullableValueToJSONObjetField(AValue, AJsonObject, AFieldName);
    tkInterface:
      ;
  end;
end;

procedure TOpenAPISerializer.ObjectToJsonObject(const AObject: TObject; const AJsonObject: TJSONObject);
var
  LType: TRttiType;
  LField: TRttiField;
  LProp: TRttiProperty;
  LFieldName: string;
begin
  LType := FRttiContext.GetType(AObject.ClassType);

  for LField in LType.GetFields do
  begin
    if not TryGetOpenAPIField(LField, LFieldName) then
      Continue;

    TValueToJsonObjectField(LField.GetValue(AObject), AJsonObject, LFieldName);
  end;

  for LProp in LType.GetProperties do
  begin
    if not TryGetOpenAPIField(LProp, LFieldName) then
      Continue;

    TValueToJsonObjectField(LProp.GetValue(AObject), AJsonObject, LFieldName);
  end;
end;

function TOpenAPISerializer.IsObjectList(const AObject: TObject): Boolean;
var
  LClass: TClass;
begin
  Result := False;
  LClass := AObject.ClassType;
  while Assigned(LClass) do
  begin
    if LClass.ClassName.StartsWith('TObjectList', True) then
    begin
      Exit(True);
    end;
    LClass := LClass.ClassParent;
  end;
end;

function TOpenAPISerializer.IsOpenAPIObjectMap(const AObject: TObject): Boolean;
var
  LClass: TClass;
begin
  Result := False;
  LClass := AObject.ClassType;
  while Assigned(LClass) do
  begin
    if LClass.ClassName.StartsWith('TOpenAPIObjectMap', True) then
    begin
      Exit(True);
    end;
    LClass := LClass.ClassParent;
  end;
end;

function TOpenAPISerializer.ObjectToJsonValue(const AObject: TObject): TJSONValue;
var
  LStr: string;
  LInt: Integer;
  LObject: TObject;
  LJsonObject: TJSONObject;
begin
  Result := nil;
  if IsOpenAPIObjectMap(AObject) then
  begin
    Result := TJSONObject.Create;
    OpenAPIObjecTMapToJSONObject(AObject, TJSONObject(Result));
  end
  else if IsObjectList(AObject) then
  begin
    Result := TJSONArray.Create;
    for LObject in TObjectList<TObject>(AObject) do
    begin
      LJsonObject := TJSONObject.Create;
      TJSONArray(Result).Add(LJsonObject);
      ObjectToJsonObject(LObject, LJsonObject);
    end;
  end
  else if AObject.ClassName.StartsWith('TList', True) then
  begin
    if AObject is TList<string> then
    begin
      Result := TJSONArray.Create;
      for LStr in TList<string>(AObject) do
      begin
        TJSONArray(Result).Add(LStr);
      end;
    end
    else if AObject is TList<Integer> then
    begin
      Result := TJSONArray.Create;
      for LInt in TList<Integer>(AObject) do
      begin
        TJSONArray(Result).Add(LStr);
      end;
    end;
  end
  else
  begin
    Result := TJSONObject.Create;
    ObjectToJsonObject(AObject, TJSONObject(Result));
  end;
end;

procedure TOpenAPISerializer.OpenAPIObjecTMapToJSONObject(const AObject; const AJsonObject: TJSONObject);
var
  LObjectMap: TOpenAPIObjectMap<TObject>;
  LKey: string;
  LObject: TObject;
  LJsonObject: TJSONObject;
begin
  LObjectMap := TOpenAPIObjectMap<TObject>(AObject);

  if LObjectMap.Ref.HasValue then
  begin
    AJsonObject.AddPair('$ref', LObjectMap.Ref.Value);
    Exit;
  end;

  for LKey in LObjectMap.Keys do
  begin
    LObject := LObjectMap[LKey];
    LJsonObject := TJSONObject.Create;
    AJsonObject.AddPair(LKey, LJsonObject);

    ObjectToJsonObject(LObject, LJsonObject);
  end;
end;

function TOpenAPISerializer.Serialize(const AOpenAPIDocument: TObject): string;
var
  LJsonObject: TJSONObject;
begin
  { MVCFramework.Serializer.JsonDataObjects }
  if not Assigned(AOpenAPIDocument) then
    Exit('');

  LJsonObject := TJSONObject.Create;
  try
    ObjectToJsonObject(AOpenAPIDocument, LJsonObject);

    Result := LJsonObject.Format;
  finally
    FreeAndNil(LJsonObject);
  end;
end;

end.
