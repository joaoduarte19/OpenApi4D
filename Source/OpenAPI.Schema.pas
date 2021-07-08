unit OpenAPI.Schema;

interface

uses
  System.Generics.Collections,
  OpenAPI.Types;

type

  TOpenAPISchema = class
  private
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TOpenAPISchemaMap = class(TObjectDictionary<string, TOpenAPISchema>)
  public
    constructor Create;
  end;

implementation

{ TOpenAPISchema }

constructor TOpenAPISchema.Create;
begin

end;

destructor TOpenAPISchema.Destroy;
begin

  inherited;
end;

{ TOpenAPISchemaMap }

constructor TOpenAPISchemaMap.Create;
begin
  inherited Create([doOwnsValues])
end;

end.
