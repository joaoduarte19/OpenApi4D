unit OpenAPI.Types;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  Nullable<T> = record
  private
    FValue: T;
    FHasValue: string;
    procedure Clear;
    function GetValue: T;
    function GetHasValue: Boolean;
    function GetIsNull: Boolean;
  public
    constructor Create(const AValue: T); overload;
    constructor Create(const AValue: Variant); overload;
    function Equals(const AValue: Nullable<T>): Boolean;
    function GetValueOrDefault: T; overload;
    function GetValueOrDefault(const ADefault: T): T; overload;
    function TryGetValue(out AValue: T): Boolean;

    property HasValue: Boolean read GetHasValue;
    property IsNull: Boolean read GetIsNull;
    property Value: T read GetValue;

    class operator Implicit(const AValue: Nullable<T>): T;
    class operator Implicit(const AValue: Nullable<T>): Variant;
    class operator Implicit(const AValue: Pointer): Nullable<T>;
    class operator Implicit(const AValue: T): Nullable<T>;
    class operator Implicit(const AValue: Variant): Nullable<T>;
    class operator Equal(const ALeft, ARight: Nullable<T>): Boolean;
    class operator NotEqual(const ALeft, ARight: Nullable<T>): Boolean;
  end;

  ENullableException = class(Exception);

  TOpenAPIObjectMap<T: class> = class(TObjectDictionary<string, T>)
  private
    FRef: Nullable<string>;
  public
    constructor Create;

    property Ref: Nullable<string> read FRef write FRef;
  end;

implementation

uses
  System.Variants,
  System.Rtti,
  System.Generics.Defaults;

{ Nullable<T> }

procedure Nullable<T>.Clear;
begin
  FValue := Default (T);
  FHasValue := '';
end;

constructor Nullable<T>.Create(const AValue: Variant);
begin
  if (not VarIsNull(AValue)) and (not VarIsEmpty(AValue)) then
    Create(TValue.FromVariant(AValue).AsType<T>)
  else
    Clear;
end;

constructor Nullable<T>.Create(const AValue: T);
begin
  FValue := AValue;
  FHasValue := DefaultTrueBoolStr;
end;

class operator Nullable<T>.Equal(const ALeft, ARight: Nullable<T>): Boolean;
begin
  Result := ALeft.Equals(ARight);
end;

function Nullable<T>.Equals(const AValue: Nullable<T>): Boolean;
begin
  if HasValue and AValue.HasValue then
    Result := TEqualityComparer<T>.Default.Equals(FValue, AValue.Value)
  else
    Result := HasValue = AValue.HasValue;
end;

function Nullable<T>.GetHasValue: Boolean;
begin
  Result := FHasValue <> '';
end;

function Nullable<T>.GetIsNull: Boolean;
begin
  Result := not HasValue;
end;

function Nullable<T>.GetValue: T;
begin
  if not HasValue then
    raise ENullableException.Create('Nullable type has no value');
  Result := FValue;
end;

function Nullable<T>.GetValueOrDefault(const ADefault: T): T;
begin
  if HasValue then
    Result := FValue
  else
    Result := ADefault;
end;

function Nullable<T>.GetValueOrDefault: T;
begin
  Result := GetValueOrDefault(Default (T));
end;

class operator Nullable<T>.Implicit(const AValue: Pointer): Nullable<T>;
begin
  if AValue = nil then
    Result.Clear
  else
    Result := Nullable<T>.Create(T(AValue^));
end;

class operator Nullable<T>.Implicit(const AValue: T): Nullable<T>;
begin
  Result := Nullable<T>.Create(AValue);
end;

class operator Nullable<T>.Implicit(const AValue: Variant): Nullable<T>;
begin
  Result := Nullable<T>.Create(AValue);
end;

class operator Nullable<T>.Implicit(const AValue: Nullable<T>): Variant;
begin
  if AValue.HasValue then
    Result := TValue.From<T>(AValue.Value).AsVariant
  else
    Result := Null;
end;

class operator Nullable<T>.Implicit(const AValue: Nullable<T>): T;
begin
  Result := AValue.Value;
end;

class operator Nullable<T>.NotEqual(const ALeft, ARight: Nullable<T>): Boolean;
begin
  Result := not ALeft.Equals(ARight);
end;

function Nullable<T>.TryGetValue(out AValue: T): Boolean;
begin
  Result := HasValue;
  if Result then
    AValue := FValue;
end;

{ TOpenAPIObjectMap<T> }

constructor TOpenAPIObjectMap<T>.Create;
begin
  inherited Create([doOwnsValues])
end;

end.
