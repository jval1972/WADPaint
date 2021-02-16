//------------------------------------------------------------------------------
//
//  WADPaint: Texture Generator from WAD resources
//  Copyright (C) 2021 by Jim Valavanis
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
//  Project file
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/wad-painter/
//------------------------------------------------------------------------------

program WADPaint;

uses
  FastMM4 in 'FastMM4.pas',
  FastMM4Messages in 'FastMM4Messages.pas',
  Forms,
  main in 'main.pas' {Form1},
  wp_undo in 'wp_undo.pas',
  wp_binary in 'wp_binary.pas',
  wp_filemenuhistory in 'wp_filemenuhistory.pas',
  wp_utils in 'wp_utils.pas',
  pngextra in 'pngextra.pas',
  pnglang in 'pnglang.pas',
  xTGA in 'xTGA.pas',
  zBitmap in 'zBitmap.pas',
  zlibpas in 'zlibpas.pas',
  wp_slider in 'wp_slider.pas',
  frm_newterrain in 'frm_newterrain.pas' {NewForm},
  wp_class in 'wp_class.pas',
  wp_wadreader in 'wp_wadreader.pas',
  pngimage1 in 'pngimage1.pas',
  wp_defs in 'wp_defs.pas',
  wp_wadwriter in 'wp_wadwriter.pas',
  wp_wad in 'wp_wad.pas',
  wp_doomdata in 'wp_doomdata.pas',
  wp_palettes in 'wp_palettes.pas',
  wp_pk3 in 'wp_pk3.pas',
  frm_loadimagehelper in 'frm_loadimagehelper.pas' {LoadImageHelperForm},
  wp_colorpickerbutton in 'wp_colorpickerbutton.pas',
  wp_colorpalettebmz in 'wp_colorpalettebmz.pas',
  wp_cursors in 'wp_cursors.pas',
  wp_quantize in 'wp_quantize.pas',
  xTIFF in 'xTIFF.pas',
  LibDelphi in 'LibDelphi.pas',
  LibJpegDelphi in 'LibJpegDelphi.pas',
  LibTiffDelphi in 'LibTiffDelphi.pas',
  wp_tmp in 'wp_tmp.pas',
  wp_doomutils in 'wp_doomutils.pas',
  wp_filters in 'wp_filters.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WAD Painter';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

