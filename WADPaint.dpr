//------------------------------------------------------------------------------
//
//  WADPaint: Texture Generator from WAD resources
//  Copyright (C)2021-2022 by Jim Valavanis
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
  wp_filters in 'wp_filters.pas',
  frm_inputnumber in 'frm_inputnumber.pas' {InputNumberForm},
  GR32 in 'Graphics32\GR32.pas',
  GR32_ArrowHeads in 'Graphics32\GR32_ArrowHeads.pas',
  GR32_Backends in 'Graphics32\GR32_Backends.pas',
  GR32_Backends_Generic in 'Graphics32\GR32_Backends_Generic.pas',
  GR32_Backends_VCL in 'Graphics32\GR32_Backends_VCL.pas',
  GR32_Bindings in 'Graphics32\GR32_Bindings.pas',
  GR32_Blend in 'Graphics32\GR32_Blend.pas',
  GR32_BlendASM in 'Graphics32\GR32_BlendASM.pas',
  GR32_BlendMMX in 'Graphics32\GR32_BlendMMX.pas',
  GR32_BlendSSE2 in 'Graphics32\GR32_BlendSSE2.pas',
  GR32_Blurs in 'Graphics32\GR32_Blurs.pas',
  GR32_Brushes in 'Graphics32\GR32_Brushes.pas',
  GR32_Clipper in 'Graphics32\GR32_Clipper.pas',
  GR32_ColorGradients in 'Graphics32\GR32_ColorGradients.pas',
  GR32_ColorPicker in 'Graphics32\GR32_ColorPicker.pas',
  GR32_ColorSwatch in 'Graphics32\GR32_ColorSwatch.pas',
  GR32_Containers in 'Graphics32\GR32_Containers.pas',
  GR32_ExtImage in 'Graphics32\GR32_ExtImage.pas',
  GR32_Filters in 'Graphics32\GR32_Filters.pas',
  GR32_Gamma in 'Graphics32\GR32_Gamma.pas',
  GR32_Geometry in 'Graphics32\GR32_Geometry.pas',
  GR32_Image in 'Graphics32\GR32_Image.pas',
  GR32_Layers in 'Graphics32\GR32_Layers.pas',
  GR32_LowLevel in 'Graphics32\GR32_LowLevel.pas',
  GR32_Math in 'Graphics32\GR32_Math.pas',
  GR32_MicroTiles in 'Graphics32\GR32_MicroTiles.pas',
  GR32_OrdinalMaps in 'Graphics32\GR32_OrdinalMaps.pas',
  GR32_Paths in 'Graphics32\GR32_Paths.pas',
  GR32_Polygons in 'Graphics32\GR32_Polygons.pas',
  GR32_PolygonsAggLite in 'Graphics32\GR32_PolygonsAggLite.pas',
  GR32_RangeBars in 'Graphics32\GR32_RangeBars.pas',
  GR32_Rasterizers in 'Graphics32\GR32_Rasterizers.pas',
  GR32_RepaintOpt in 'Graphics32\GR32_RepaintOpt.pas',
  GR32_Resamplers in 'Graphics32\GR32_Resamplers.pas',
  GR32_System in 'Graphics32\GR32_System.pas',
  GR32_Text_VCL in 'Graphics32\GR32_Text_VCL.pas',
  GR32_Transforms in 'Graphics32\GR32_Transforms.pas',
  GR32_VectorMaps in 'Graphics32\GR32_VectorMaps.pas',
  GR32_VectorUtils in 'Graphics32\GR32_VectorUtils.pas',
  GR32_VPR in 'Graphics32\GR32_VPR.pas',
  GR32_VPR2 in 'Graphics32\GR32_VPR2.pas',
  GR32_XPThemes in 'Graphics32\GR32_XPThemes.pas',
  frm_remapcolorchannels in 'frm_remapcolorchannels.pas' {RemapColorChannelsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WAD Painter';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

