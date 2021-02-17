unit frm_remapcolorchannels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TRemapColorChannelsForm = class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    Panel2: TPanel;
    RadioGroup3: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup1: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function RemapColorChannelsQuery(var r, g, b: integer): boolean;


implementation

{$R *.dfm}

function RemapColorChannelsQuery(var r, g, b: integer): boolean;
var
  f: TRemapColorChannelsForm;
begin
  Result := False;
  f := TRemapColorChannelsForm.Create(nil);
  try
    f.ShowModal;
    if f.ModalResult = mrOK then
    begin
      Result := True;
      r := f.RadioGroup1.ItemIndex;
      g := f.RadioGroup2.ItemIndex;
      b := f.RadioGroup3.ItemIndex;
    end;
  finally
    f.Free;
  end;
end;

end.
