//------------------------------------------------------------------------------
//
//  WADPaint: Texture Generator from WAD resources
//  Copyright (C) 2021-2022 by Jim Valavanis
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//  WAD Reader
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/wad-painter/
//------------------------------------------------------------------------------

unit wp_wadreader;

interface

uses
  Classes, SysUtils, wp_wad;

type
  TWadReader = class(TObject)
  private
    h: wadinfo_t;
    la: Pfilelump_tArray;
    ss: TStream;
    ffilename: string;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure OpenWadFile(const aname: string);
    procedure LoadFromStream(const strm: TStream);
    function EntryAsString(const id: integer): string; overload;
    function EntryAsString(const aname: string): string; overload;
    function ReadEntry(const id: integer; var buf: pointer; var bufsize: integer): boolean; overload;
    function ReadEntry(const aname: string; var buf: pointer; var bufsize: integer): boolean; overload;
    function EntryName(const id: integer): string;
    function EntryId(const aname: string): integer;
    function EntryInfo(const id: integer): Pfilelump_t; overload;
    function EntryInfo(const aname: string): Pfilelump_t; overload;
    function NumEntries: integer;
    property FileName: string read ffilename;
  end;

implementation

constructor TWadReader.Create;
begin
  h.identification := 0;
  h.numlumps := 0;
  h.infotableofs := 0;
  la := nil;
  ss := nil;
  ffilename := '';
  Inherited;
end;

destructor TWadReader.Destroy;
begin
  Clear;
  Inherited;
end;

procedure TWadReader.Clear;
begin
  if h.numlumps > 0 then
  begin
    FreeMem(la, h.numlumps * SizeOf(filelump_t));
    h.identification := 0;
    h.numlumps := 0;
    h.infotableofs := 0;
    la := nil;
    ffilename := '';
  end
  else
  begin
    h.identification := 0;
    h.infotableofs := 0;
  end;
  if ss <> nil then
  begin
    ss.Free;
    ss := nil;
  end;
end;

procedure TWadReader.OpenWadFile(const aname: string);
begin
  if aname = '' then
    Exit;
  Clear;
  if not FileExists(aname) then
    Exit;

  ss := TFileStream.Create(aname, fmOpenRead or fmShareDenyWrite);

  ss.Read(h, SizeOf(wadinfo_t));
  if (h.numlumps > 0) and (h.infotableofs < ss.Size) and ((h.identification = IWAD) or (h.identification = PWAD)) then
  begin
    ss.Position := h.infotableofs;
    GetMem(la, h.numlumps * SizeOf(filelump_t));
    ss.Read(la^, h.numlumps * SizeOf(filelump_t));
    ffilename := aname;
  end;
end;

procedure TWadReader.LoadFromStream(const strm: TStream);
begin
  Clear;
  ss := TMemoryStream.Create;
  ss.CopyFrom(strm, strm.Size);
  ss.Position := 0;
  if ss.Size > SizeOf(wadinfo_t) then
  begin
    ss.Read(h, SizeOf(wadinfo_t));
    if (h.numlumps > 0) and (h.infotableofs < ss.Size) and ((h.identification = IWAD) or (h.identification = PWAD)) then
    begin
      ss.Position := h.infotableofs;
      GetMem(la, h.numlumps * SizeOf(filelump_t));
      ss.Read(la^, h.numlumps * SizeOf(filelump_t));
      ffilename := '';
    end;
  end;
end;

function TWadReader.EntryAsString(const id: integer): string;
begin
  if (ss <> nil) and (id >= 0) and (id < h.numlumps) then
  begin
    SetLength(Result, la[id].size);
    ss.Position := la[id].filepos;
    ss.Read((@Result[1])^, la[id].size);
  end
  else
    Result := '';
end;

function TWadReader.EntryAsString(const aname: string): string;
var
  id: integer;
begin
  id := EntryId(aname);
  if id >= 0 then
    Result := EntryAsString(id)
  else
    Result := '';
end;

function TWadReader.ReadEntry(const id: integer; var buf: pointer; var bufsize: integer): boolean;
begin
  if (ss <> nil) and (id >= 0) and (id < h.numlumps) then
  begin
    ss.Position := la[id].filepos;
    bufsize := la[id].size;
    GetMem(buf, bufsize);
    ss.Read(buf^, bufsize);
    Result := true;
  end
  else
    Result := False;
end;

function TWadReader.ReadEntry(const aname: string; var buf: pointer; var bufsize: integer): boolean;
var
  id: integer;
begin
  id := EntryId(aname);
  if id >= 0 then
    Result := ReadEntry(id, buf, bufsize)
  else
    Result := False;
end;

function TWadReader.EntryName(const id: integer): string;
begin
  if (id >= 0) and (id < h.numlumps) then
    Result := char8tostring(la[id].name)
  else
    Result := '';
end;

function TWadReader.EntryId(const aname: string): integer;
var
  i: integer;
  uname: string;
begin
  uname := UpperCase(aname);
  for i := h.numlumps - 1 downto 0 do
    if UpperCase(char8tostring(la[i].name)) = uname then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

function TWadReader.EntryInfo(const id: integer): Pfilelump_t;
begin
  if (id >= 0) and (id < h.numlumps) then
    Result := @la[id]
  else
    Result := nil;
end;

function TWadReader.EntryInfo(const aname: string): Pfilelump_t;
begin
  Result := EntryInfo(EntryId(aname));
end;

function TWadReader.NumEntries: integer;
begin
  Result := h.numlumps;
end;

end.

