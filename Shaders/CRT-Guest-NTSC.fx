/*

	CRT - Guest - NTSC (Copyright (C) 2018-2023 guest(r) - guest.r@gmail.com)

	Incorporates many good ideas and suggestions from Dr. Venom.

	I would also like give thanks to many Libretro forums members for continuous feedbacks, suggestions and caring about the shader.

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

	This program is distributed in the hopes that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along with this program; if not,
	write to the Free Software Foundation, Inc, 59 Temple Place - STE 330, Boston, MA 02111-1307, USA.

	Ported to ReShade by DevilSingh with some help from guest(r)

*/

uniform float ResolutionX <
	ui_label = "Resolution X";
> = 320.0;

uniform float ResolutionY <
	ui_label = "Resolution Y";
> = 240.0;

uniform float quality <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 2.0;
	ui_step = 1.0;
	ui_label = "NTSC Preset: SVideo=0 | Composite=1 | RF=2 | Custom=-1";
> = 1.0;

uniform float ntsc_fields <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "NTSC Merge Fields";
> = 0.0;

uniform float ntsc_phase <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 3.0;
	ui_step = 1.0;
	ui_label = "NTSC Phase: Auto | 2 Phase | 3 Phase";
> = 1.0;

uniform float ntsc_scale <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 2.5;
	ui_step = 0.025;
	ui_label = "NTSC Resolution Scaling";
> = 1.0;

uniform float ntsc_cscale <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 2.25;
	ui_step = 0.05;
	ui_label = "NTSC Chroma Scaling/Bleeding";
> = 1.0;

uniform float ntsc_sat <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.01;
	ui_label = "NTSC Color Saturation";
> = 1.0;

uniform float ntsc_bright <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.5;
	ui_step = 0.01;
	ui_label = "NTSC Brightness";
> = 1.0;

uniform float cust_fringing <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "NTSC Custom Fringing Value";
> = 0.0;

uniform float cust_artifacting <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "NTSC Custom Artifacting Value";
> = 0.0;

uniform float ntsc_ring <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "NTSC Anti-Ringing";
> = 0.0;

uniform float ntsc_shrp <
	ui_type = "drag";
	ui_min = -10.0;
	ui_max = 10.0;
	ui_step = 0.5;
	ui_label = "NTSC Sharpness (Negative:Adaptive)";
> = 0.0;

uniform float ntsc_shpe <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "NTSC Sharpness Shape";
> = 0.75;

uniform float blendMode <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "NTSC Blend Mode (Main Mode Control)";
> = 1.0;

uniform float CSHARPEN <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "Sharpen Strength";
> = 0.0;

uniform float CCONTR <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.25;
	ui_step = 0.01;
	ui_label = "Amount Of Sharpening";
> = 0.05;

uniform float CDETAILS <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Details Sharpened";
> = 1.0;

uniform float vigstr <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Vignette Strength";
> = 0.0;

uniform float vigdef <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 3.0;
	ui_step = 0.1;
	ui_label = "Vignette Size";
> = 1.0;

uniform float lsmooth <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 1.0;
	ui_step = 0.01;
	ui_label = "Raster Bloom Effect Smoothing";
> = 0.7;

uniform float gamma_i <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 5.0;
	ui_step = 0.05;
	ui_label = "Gamma Input";
> = 2.00;

uniform float gamma_o <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 5.0;
	ui_step = 0.05;
	ui_label = "Gamma Out";
> = 1.95;

uniform float inter <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 800.0;
	ui_step = 25.0;
	ui_label = "Interlace Trigger Resolution";
> = 400.0;

uniform float interm <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 1.0;
	ui_label = "Interlace Mode: 0:OFF | 1-3:Normal | 4-5:Interpolation";
> = 1.0;

uniform float iscan <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Interlacing Scanline Effect (Interlaced Brightness)";
> = 0.2;

uniform float iscans <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Interlacing Scanline Saturation";
> = 0.25;

uniform float intres <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 6.0;
	ui_step = 0.5;
	ui_label = "Internal Resolution Y: 0.5 | Y-Dowsample";
> = 0.0;

uniform float downsample_levelx <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 0.05;
	ui_label = "Downsampling-X (High-Res Content, Pre-Scalers)";
> = 0.0;

uniform float downsample_levely <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 0.05;
	ui_label = "Downsampling-Y (High-Res Content, Pre-Scalers)";
> = 0.0;

uniform float m_glow <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Ordinary Glow | Magic Glow";
> = 0.0;

uniform float m_glow_cutoff <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.4;
	ui_step = 0.01;
	ui_label = "Magic Glow Cutoff";
> = 0.12;

uniform float m_glow_low <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 7.0;
	ui_step = 0.05;
	ui_label = "Magic Glow Low Strength";
> = 0.35;

uniform float m_glow_high <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 7.0;
	ui_step = 0.05;
	ui_label = "Magic Glow High Strength";
> = 5.0;

uniform float m_glow_dist <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 4.0;
	ui_step = 0.05;
	ui_label = "Magic Glow Distribution";
> = 1.0;

uniform float m_glow_mask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.025;
	ui_label = "Magic Glow Mask Strength";
> = 1.0;

uniform float SIZEH <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 50.0;
	ui_step = 1.0;
	ui_label = "Horizontal Glow Radius";
> = 6.0;

uniform float SIGMA_H <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 15.0;
	ui_step = 0.1;
	ui_label = "Horizontal Glow Sigma";
> = 1.2;

uniform float SIZEV <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 50.0;
	ui_step = 1.0;
	ui_label = "Vertical Glow Radius";
> = 6.0;

uniform float SIGMA_V <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 15.0;
	ui_step = 0.1;
	ui_label = "Vertical Glow Sigma";
> = 1.2;

uniform float SIZEX <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 50.0;
	ui_step = 1.0;
	ui_label = "Horizontal Bloom/Halation/(Glow) Radius";
> = 3.0;

uniform float SIGMA_X <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 15.0;
	ui_step = 0.05;
	ui_label = "Horizontal Bloom/Halation/(Glow) Sigma";
> = 0.75;

uniform float BLOOMCUT_X <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.5;
	ui_step = 0.01;
	ui_label = "Horizontal Bloom/Halation/(Glow) Substract";
> = 0.0;

uniform float SIZEY <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 50.0;
	ui_step = 1.0;
	ui_label = "Vertical Bloom/Halation/(Glow) Radius";
> = 3.0;

uniform float SIGMA_Y <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 15.0;
	ui_step = 0.05;
	ui_label = "Vertical Bloom/Halation/(Glow) Sigma";
> = 0.60;

uniform float BLOOMCUT_Y <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.5;
	ui_step = 0.01;
	ui_label = "Vertical Bloom/Halation/(Glow) Substract";
> = 0.0;

uniform float HSHARPNESS <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 8.0;
	ui_step = 0.05;
	ui_label = "Horizontal Filter Range";
> = 1.5;

uniform float SIGMA_HOR <
	ui_type = "drag";
	ui_min = 0.1;
	ui_max = 7.0;
	ui_step = 0.05;
	ui_label = "Horizontal Blur Sigma";
> = 0.9;

uniform float S_SHARPH <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.1;
	ui_label = "Substractive Sharpness";
> = 0.9;

uniform float HSHARP <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.1;
	ui_label = "Sharpness Definition";
> = 1.2;

uniform float HARNG <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 4.0;
	ui_step = 0.1;
	ui_label = "Substractive Sharpness Ringing";
> = 0.4;

uniform float MAXS <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.3;
	ui_step = 0.01;
	ui_label = "Maximum Sharpness";
> = 0.15;

uniform float glow <
	ui_type = "drag";
	ui_min = -2.0;
	ui_max = 2.0;
	ui_step = 0.01;
	ui_label = "(Magic) Glow Strength";
> = 0.08;

uniform float blm_1 <
	ui_type = "drag";
	ui_min = -2.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Bloom Strength";
> = 0.0;

uniform float mask_bloom <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Mask Bloom";
> = 0.0;

uniform float bloom_dist <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 0.05;
	ui_label = "Bloom Distribution";
> = 0.0;

uniform float halation <
	ui_type = "drag";
	ui_min = -2.0;
	ui_max = 2.0;
	ui_step = 0.025;
	ui_label = "Halation Strength";
> = 0.0;

uniform float gamma_c <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 2.0;
	ui_step = 0.025;
	ui_label = "Gamma Correct";
> = 1.0;

uniform float brightboost1 <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 10.0;
	ui_step = 0.05;
	ui_label = "Bright Boost Dark Pixels";
> = 1.4;

uniform float brightboost2 <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 3.0;
	ui_step = 0.025;
	ui_label = "Bright Boost Bright Pixels";
> = 1.1;

uniform float gsl <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 2.0;
	ui_step = 1.0;
	ui_label = "Scanline Type";
> = 0.0;

uniform float scanline1 <
	ui_type = "drag";
	ui_min = -20.0;
	ui_max = 40.0;
	ui_step = 0.5;
	ui_label = "Scanline Beam Shape Center";
> = 6.0;

uniform float scanline2 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 70.0;
	ui_step = 1.0;
	ui_label = "Scanline Beam Shape Edges";
> = 8.0;

uniform float beam_min <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 10.0;
	ui_step = 0.05;
	ui_label = "Scanline Shape Dark Pixels";
> = 1.3;

uniform float beam_max <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 3.5;
	ui_step = 0.01;
	ui_label = "Scanline Shape Bright Pixels";
> = 1.0;

uniform float beam_size <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Increased Bright Scanline Beam";
> = 0.6;

uniform float scans <
	ui_type = "drag";
	ui_min = -5.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "Scanline Saturation / Mask Falloff";
> = 0.5;

uniform float scan_falloff <
	ui_type = "drag";
	ui_min = 0.15;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Scanline Falloff";
> = 1.0;

uniform float spike <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.1;
	ui_label = "Scanline Spike Removal";
> = 1.0;

uniform float rolling_scan <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.01;
	ui_label = "Rolling Scanline";
> = 0.0;

uniform float scangamma <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 5.0;
	ui_step = 0.05;
	ui_label = "Scanline Gamma";
> = 2.4;

uniform float no_scanlines <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.5;
	ui_step = 0.05;
	ui_label = "No-Scanline Mode";
> = 0.0;

uniform float IOS <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 4.0;
	ui_step = 1.0;
	ui_label = "Integer Scaling: Odd:Y | Even:X+Y";
> = 0.0;

uniform float OS <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 1.0;
	ui_label = "Raster Bloom Overscan Mode";
> = 1.0;

uniform float blm_2 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 20.0;
	ui_step = 1.0;
	ui_label = "Raster Bloom %";
> = 0.0;

uniform float csize <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.25;
	ui_step = 0.01;
	ui_label = "Corner Size";
> = 0.0;

uniform float bsize1 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 0.01;
	ui_label = "Border Size";
> = 0.01;

uniform float sborder <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Border Intensity";
> = 0.75;

uniform float barspeed <
	ui_type = "drag";
	ui_min = 5.0;
	ui_max = 200.0;
	ui_step = 1.0;
	ui_label = "Hum Bar Speed";
> = 50.0;

uniform float barintensity <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.01;
	ui_label = "Hum Bar Intensity";
> = 0.0;

uniform float bardir <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Hum Bar Direction";
> = 0.0;

uniform float warpx <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.25;
	ui_step = 0.01;
	ui_label = "Curvature X (Default 0.03)";
> = 0.0;

uniform float warpy <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.25;
	ui_step = 0.01;
	ui_label = "Curvature Y (Default 0.04)";
> = 0.0;

uniform float c_shape <
	ui_type = "drag";
	ui_min = 0.05;
	ui_max = 0.6;
	ui_step = 0.05;
	ui_label = "Curvature Shape";
> = 0.25;

uniform float overscanx <
	ui_type = "drag";
	ui_min = -200.0;
	ui_max = 200.0;
	ui_step = 1.0;
	ui_label = "Overscan X Original Pixels";
> = 0.0;

uniform float overscany <
	ui_type = "drag";
	ui_min = -200.0;
	ui_max = 200.0;
	ui_step = 1.0;
	ui_label = "Overscan Y Original Pixels";
> = 0.0;

uniform float shadow_msk <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 14.0;
	ui_step = 1.0;
	ui_label = "CRT Mask: 0:CGWG | 1-4:Lottes | 5-13:Trinitron";
> = 1.0;

uniform float maskstr <
	ui_type = "drag";
	ui_min = -0.5;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "Mask Strength (0, 5-12)";
> = 0.3;

uniform float mcut <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Mask 5-12 Low Strength";
> = 1.1;

uniform float maskboost <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 3.0;
	ui_step = 0.05;
	ui_label = "CRT Mask Boost";
> = 1.0;

uniform float masksize <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 4.0;
	ui_step = 1.0;
	ui_label = "CRT Mask Size";
> = 1.0;

uniform float mask_zoom <
	ui_type = "drag";
	ui_min = -4.0;
	ui_max = 4.0;
	ui_step = 1.0;
	ui_label = "CRT Mask Zoom (+ Mask Width)";
> = 0.0;

uniform float mask_drk <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Lottes Mask Dark";
> = 0.5;

uniform float mask_lgt <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Lottes Mask Light";
> = 1.5;

uniform float mshift <
	ui_type = "drag";
	ui_min = -8.0;
	ui_max = 8.0;
	ui_step = 0.5;
	ui_label = "Mask Shift/Stagger";
> = 0.0;

uniform float mask_layout <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Mask Layout: RGB or BGR (Check LCD Panel)";
> = 0.0;

uniform float mask_gamma <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 5.0;
	ui_step = 0.05;
	ui_label = "Mask Gamma";
> = 2.4;

uniform float slotmask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Slot Mask Strength Bright Pixels";
> = 0.0;

uniform float slotmask1 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Slot Mask Strength Dark Pixels";
> = 0.0;

uniform float slotwidth <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 16.0;
	ui_step = 1.0;
	ui_label = "Slot Mask Width (0:Auto)";
> = 0.0;

uniform float double_slot <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 4.0;
	ui_step = 1.0;
	ui_label = "Slot Mask Height: 2x1 or 4x1";
> = 2.0;

uniform float slotms <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 4.0;
	ui_step = 1.0;
	ui_label = "Slot Mask Thickness";
> = 1.0;

uniform float mclip <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Keep Mask Effect With Clipping";
> = 0.0;

uniform float smoothmask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Smooth Masks In Bright Scanlines";
> = 0.0;

uniform float smask_mit <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Mitigate Slot Mask Interaction";
> = 0.0;

uniform float dctypex <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.75;
	ui_step = 0.05;
	ui_label = "Deconvergence Type X: 0:Static | Other:Dynamic";
> = 0.0;

uniform float dctypey <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.75;
	ui_step = 0.05;
	ui_label = "Deconvergence Type Y: 0:Static | Other:Dynamic";
> = 0.0;

uniform float deconrx <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Horizontal Deconvergence Red Range";
> = 0.0;

uniform float decongx <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Horizontal Deconvergence Green Range";
> = 0.0;

uniform float deconbx <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Horizontal Deconvergence Blue Range";
> = 0.0;

uniform float deconry <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Vertical Deconvergence Red Range";
> = 0.0;

uniform float decongy <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Vertical Deconvergence Green Range";
> = 0.0;

uniform float deconby <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Vertical Deconvergence Blue Range";
> = 0.0;

uniform float decons <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 0.1;
	ui_label = "Deconvergence Strength";
> = 1.0;

uniform float addnoised <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.02;
	ui_label = "Add Noise";
> = 0.0;

uniform float noiseresd <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 10.0;
	ui_step = 1.0;
	ui_label = "Noise Resolution";
> = 2.0;

uniform float noisetype <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Noise Type: Colored | Luma";
> = 0.0;

uniform float post_br <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 5.0;
	ui_step = 0.01;
	ui_label = "Post Brightness";
> = 1.0;

#include "ReShade.fxh"

#define SIGNAL1 float2(4.0*ResolutionX,ResolutionY)
#define SIGNAL2 float2(2.0*ResolutionX,ResolutionY)
#define TexSize float2(ResolutionX,ResolutionY)
#define IptSize float2(800.0000000,600.0000000)
#define OptSize float4(BUFFER_SCREEN_SIZE,1.0/BUFFER_SCREEN_SIZE)
#define OrgSize float4(TexSize,1.0/TexSize)
#define SrcSize float4(IptSize,1.0/IptSize)
#define FragCoord (texcoord*OptSize.xy)
#define pii 3.14159265
#define eps 1e-8
#define COMPAT_TEXTURE(c,d) tex2D(c,d)
#define NTSC_01 float4(SIGNAL1,1.0/SIGNAL1)
#define NTSC_02 float4(SIGNAL2,1.0/SIGNAL2)
#define mix_m float3x3(BRIGHTNESS,ARTIFACTING,ARTIFACTING,FRINGING,2.0*SATURATION,0.0,FRINGING,0.0,2.0*SATURATION)
#define rgb_m float3x3(0.299,0.587,0.114,0.596,-0.274,-0.322,0.211,-0.523,0.312)
#define yiq_m float3x3(1.000,0.956,0.621,1.000,-0.272,-0.647,1.000,-1.106,1.703)
#define tex_1 texcoord-float2(0.50/NTSC_01.x,0.0)
#define tex_2 texcoord-float2(0.25/NTSC_02.x,0.0)
#define inv_sqr_h 1.0/(2.0*SIGMA_H*SIGMA_H)
#define inv_sqr_v 1.0/(2.0*SIGMA_V*SIGMA_V)
#define inv_sqr_x 1.0/(2.0*SIGMA_X*SIGMA_X)
#define inv_sqr_y 1.0/(2.0*SIGMA_Y*SIGMA_Y)
#define invsigmah 1.0/(2.0*SIGMA_HOR*SIGMA_HOR)
#define fetch_offset(offset,one_x) float3(tex2D(NTSC_S02,tex_1+float2((offset)*(one_x),0.0)).x,tex2D(NTSC_S02,tex_1+float2((offset)*(one_x/ntsc_cscale),0.0)).yz)

#ifndef Resolution_X
#define Resolution_X 320
#endif

#ifndef Resolution_Y
#define Resolution_Y 240
#endif

#define NTSC_S00 ReShade::BackBuffer

texture NTSC_T01{Width=1.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S01{Texture=NTSC_T01;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=POINT ;MinFilter=POINT ;MipFilter=POINT ;};

texture NTSC_T02{Width=4.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S02{Texture=NTSC_T02;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=POINT ;MinFilter=POINT ;MipFilter=POINT ;};

texture NTSC_T03{Width=2.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S03{Texture=NTSC_T03;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T04{Width=2.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S04{Texture=NTSC_T04;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T05{Width=2.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S05{Texture=NTSC_T05;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T06{Width=2.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S06{Texture=NTSC_T06;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T07{Width=2.0*Resolution_X;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S07{Texture=NTSC_T07;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T08{Width=1.0*BUFFER_WIDTH;Height=Resolution_Y ;Format=RGBA16F;};
sampler NTSC_S08{Texture=NTSC_T08;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T09{Width=1.0*800.00000000;Height=600.00000000 ;Format=RGBA16F;};
sampler NTSC_S09{Texture=NTSC_T09;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T10{Width=1.0*800.00000000;Height=600.00000000 ;Format=RGBA16F;};
sampler NTSC_S10{Texture=NTSC_T10;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T11{Width=1.0*800.00000000;Height=600.00000000 ;Format=RGBA16F;};
sampler NTSC_S11{Texture=NTSC_T11;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T12{Width=1.0*800.00000000;Height=600.00000000 ;Format=RGBA16F;};
sampler NTSC_S12{Texture=NTSC_T12;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

texture NTSC_T13{Width=1.0*BUFFER_WIDTH;Height=BUFFER_HEIGHT;Format=RGBA16F;};
sampler NTSC_S13{Texture=NTSC_T13;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

uniform int framecount<source="framecount";>;

float3 plant(float3 tar,float r)
{
	float t=max(max(tar.r,tar.g),tar.b)+0.00001;
	return tar*r/t;
}

float dist(float3 A,float3 B)
{
	float r=0.5*(A.r+B.r);
	float3 d=A-B;
	float3 c=float3(2.+r,4.,3.-r);
	return sqrt(dot(c*d,d))/3.;
}

float vignette(float2 pos)
{
	float2 b=vigdef*float2(1.0,OrgSize.x/OrgSize.y)*0.125;
	pos=clamp(pos,0.0,1.0);
	pos=abs(2.0*(pos-0.5));
	float2 res=lerp(0.0.xx,1.0.xx,smoothstep(1.0.xx,1.0.xx-b,sqrt(pos)));
	res=pow(res,0.70.xx);
	return max(lerp(1.0,sqrt(res.x*res.y),vigstr),0.0);
}

float3 fetch_pixel(float2 coord)
{
	float2 dx=float2(OrgSize.z,0.0)*downsample_levelx;
	float2 dy=float2(0.0,OrgSize.w)*downsample_levely;
	float2 d1=dx+dy;
	float2 d2=dx-dy;
	float sum=15.0;
	float3 result=3.0*COMPAT_TEXTURE(NTSC_S05,coord).rgb+2.0*COMPAT_TEXTURE(NTSC_S05,coord+dx).rgb+2.0*COMPAT_TEXTURE(NTSC_S05,coord-dx).rgb+
	2.0*COMPAT_TEXTURE(NTSC_S05,coord+dy).rgb+2.0*COMPAT_TEXTURE(NTSC_S05,coord-dy).rgb+COMPAT_TEXTURE(NTSC_S05,coord+d1).rgb+
	COMPAT_TEXTURE(NTSC_S05,coord-d1).rgb+COMPAT_TEXTURE(NTSC_S05,coord+d2).rgb+COMPAT_TEXTURE(NTSC_S05,coord-d2).rgb;
	return result/sum;
}

float gauss_h(float x)
{
	return exp(-x*x*inv_sqr_h);
}

float gauss_v(float x)
{
	return exp(-x*x*inv_sqr_v);
}

float gauss_x(float x)
{
	return exp(-x*x*inv_sqr_x);
}

float gauss_y(float x)
{
	return exp(-x*x*inv_sqr_y);
}

float crthd_h(float x)
{
	return exp(-x*x*invsigmah);
}

float mod(float x,float y)
{
	return x-y* floor(x/y);
}

float st0(float x)
{
	return exp2(-10.0*x*x);
}

float st1(float x)
{
	return exp2(- 7.0*x*x);
}

float sw0(float x,float color,float scanline)
{
	float tmp=lerp(beam_min,beam_max,color);
	float ex=x*tmp;
	ex=(gsl>-0.5)?ex*ex:lerp(ex*ex,ex*ex*ex,0.4);
	return exp2(-scanline*ex);
}

float sw1(float x,float color,float scanline)
{
	x=lerp(x,beam_min*x,max(x-0.4*color,0.0));
	float tmp=lerp(1.2*beam_min,beam_max,color);
	float ex=x*tmp;
	return exp2(-scanline*ex*ex);
}

float sw2(float x,float color,float scanline)
{
	float tmp=lerp((2.5-0.5*color)*beam_min,beam_max,color);
	tmp=lerp(beam_max,tmp,pow(x,color+0.3));
	float ex=x*tmp;
	return exp2(-scanline*ex*ex);
}

float2 overscan(float2 pos,float dx,float dy)
{
	pos=pos*2.0-1.0;
	pos*=float2(dx,dy);
	return pos*0.5+0.5;
}

float2 warp(float2 pos)
{
	pos=pos*2.0-1.0;
	pos=lerp(pos,float2(pos.x*rsqrt(1.0-c_shape*pos.y*pos.y),pos.y*rsqrt(1.0-c_shape*pos.x*pos.x)),float2(warpx,warpy)/c_shape);
	return pos*0.5+0.5;
}

float3 gc(float3 c)
{
	float mc=max(max(c.r,c.g),c.b);
	float mg=pow(mc,1.0/gamma_c);
	return c*mg/(mc+eps);
}

float3 rgb2yiq(float3 r)
{
	return mul(rgb_m, r);
}

float3 yiq2rgb(float3 y)
{
	return mul(yiq_m, y);
}

float3 crt_mask(float2 pos,float mx,float mb)
{
	float3 mask=mask_drk;
	float3 one=1.0;
	if(shadow_msk== 0.0)
	{
	mask=one;
	}else
	if(shadow_msk== 1.0)
	{
	float mc=1.0-max(maskstr,0.0);
	pos.x=frac(pos.x*0.5);
	if(pos.x<0.49)
	{
	mask.r=1.0;mask.g= mc;mask.b=1.0;
	}else
	{
	mask.r= mc;mask.g=1.0;mask.b= mc;
	}
	}else
	if(shadow_msk== 2.0)
	{
	float line=mask_lgt;
	float odd=0.0;
	if(frac(pos.x/6.0)<0.49)odd=1.0;
	if(frac((pos.y+odd)/2.0)<0.49)line=mask_drk;
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=mask_lgt;else
	if(pos.x<1.5)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	mask*=line;
	}else
	if(shadow_msk== 3.0)
	{
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=mask_lgt;else
	if(pos.x<1.5)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	}else
	if(shadow_msk== 4.0)
	{
	pos.x+=pos.y*3.0;
	pos.x=frac(pos.x/6.0);
	if(pos.x<0.3)mask.r=mask_lgt;else
	if(pos.x<0.6)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	}else
	if(shadow_msk== 5.0)
	{
	pos.xy=floor(pos.xy*float2(1.0,0.5));
	pos.x+=pos.y*3.0;
	pos.x=frac(pos.x/6.0);
	if(pos.x<0.3)mask.r=mask_lgt;else
	if(pos.x<0.6)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	}else
	if(shadow_msk== 6.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/2.0);
	if(pos.x<0.49)
	{
	mask.r=1.0;
	mask.b=1.0;
	}else
	mask.g=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 7.0)
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=1.0;else
	if(pos.x<1.5)mask.g=1.0;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 8.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/2.0);
	if(pos.x<0.49)
	{
	mask=0.0.xxx;
	}else
	mask=1.0.xxx;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 9.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/3.0);
	if(pos.x<0.3)mask=0.0.xxx;else
	if(pos.x<0.6)mask=1.0.xxx;else
	mask=1.0.xxx;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==10.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/3.0);
	if(pos.x<0.3)mask   =0.0.xxx;else
	if(pos.x<0.6)mask.rb=1.0.xx ;else
	mask.g=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==11.0)
	{
	mask=0.0;
	pos.x=frac(pos.x*0.25);
	if(pos.x<0.2)mask  =0.0.xxx;else
	if(pos.x<0.4)mask.r=1.0    ;else
	if(pos.x<0.7)mask.g=1.0    ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==12.0)
	{
	mask=0.0;
	pos.x=frac(pos.x*0.25);
	if(pos.x<0.2)mask.r =1.0   ;else
	if(pos.x<0.4)mask.rg=1.0.xx;else
	if(pos.x<0.7)mask.gb=1.0.xx;else
	mask.b=1.0;mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==13.0)
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,7.0));
	if(pos.x<0.5)mask  =0.0.xxx;else
	if(pos.x<2.5)mask.r=1.0    ;else
	if(pos.x<4.5)mask.g=1.0    ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,6.0));
	if(pos.x<0.5)mask    =0.0.xxx;else
	if(pos.x<1.5)mask.r  =1.0    ;else
	if(pos.x<2.5)mask.rg =1.0.xx ;else
	if(pos.x<3.5)mask.rgb=1.0.xxx;else
	if(pos.x<4.5)mask.gb =1.0.xx ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}
	if(mask_layout>0.5)mask=mask.rbg;
	float maskmin=min(min(mask.r,mask.g),mask.b);
	return (mask-maskmin)*(1.0+(maskboost-1.0)*mb)+maskmin;
}

float slt_mask(float2 pos,float m,float swidth)
{
	if  ((slotmask+slotmask1)==0.0)return 1.0;else
	{
	pos.y=floor(pos.y/slotms);
	float mlen=swidth*2.0;
	float px=floor( mod(pos.x,0.99999*mlen));
	float py=floor(frac(pos.y/(2.0*double_slot))*2.0*double_slot);
	float slot_dark=lerp(1.0-slotmask1,1.0-slotmask,m);
	float slot=1.0;
	if(py==0.0&&px<swidth)slot=slot_dark;else
	if(py==double_slot&&px>=swidth)slot=slot_dark;
	return slot;
	}
}

float humbars(float pos)
{
	if  (barintensity==0.0)return 1.0;else
	{
	pos=(barintensity>=0.0)?pos:(1.0-pos);
	pos=frac(pos+ mod(float(framecount),barspeed)/(barspeed-1.0));
	pos=(barintensity< 0.0)?pos:(1.0-pos);
	return (1.0-barintensity)+barintensity*pos;
	}
}

float corner(float2 pos)
{
	float2 b=bsize1* float2(1.0,OptSize.x/OptSize.y)*0.05;
	pos=clamp(pos,0.0,1.0);
	pos=abs(2.0*(pos-0.5));
	float csize1=lerp(400.0,7.0,pow(4.0*csize,0.10));
	float crn=dot(pow(pos,csize1.xx),float2(1.0,OptSize.y/OptSize.x));
	crn=(csize==0.0)?max(pos.x,pos.y):pow(crn,1.0/csize1);
	pos=max(pos,crn);
	float2 res=(bsize1==0.0)?1.0.xx:lerp(0.0.xx,1.0.xx,smoothstep(1.0.xx,1.0.xx-b,sqrt(pos)));
	res=pow(res, sborder.xx);
	return sqrt(res.x*res.y);
}

float3 declip(float3 c,float b)
{
	float m=max(max(c.r,c.g),c.b);
	if(m>b)c=c*b/m;
	return c;
}

float igc(float mc)
{
	return pow(mc,gamma_c);
}

float3 noise(float3 v)
{
	if(addnoised<0.0) {v.z=-addnoised;}else{v.z= mod(v.z,6001.0)/1753.0;}
	v =frac(v)+frac(v*1e4)+frac(v*1e-4);
	v+=float3(0.12345,0.6789,0.314159);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	return v;
}

void bring_pixel(inout float3 c,inout float3 b,float2 coord,float2 boord)
{
	float stepx=OptSize.z;
	float stepy=OptSize.w;
	float2 dx=float2(stepx,0.0);
	float2 dy=float2(0.0,stepy);
	float posx= 2.0*coord.x-1.0;
	float posy= 2.0*coord.y-1.0;
	if(dctypex>0.025)
	{
	posx= sign(posx)*pow(abs(posx),1.05-dctypex);
	dx=posx*dx;
	}
	if(dctypey>0.025)
	{
	posy= sign(posy)*pow(abs(posy),1.05-dctypey);
	dy=posy*dy;
	}
	float2 rc=deconrx*dx+deconry*dy;
	float2 gc=decongx*dx+decongy*dy;
	float2 bc=deconbx*dx+deconby*dy;
	float r1=COMPAT_TEXTURE(NTSC_S13,coord+rc).r;
	float g1=COMPAT_TEXTURE(NTSC_S13,coord+gc).g;
	float b1=COMPAT_TEXTURE(NTSC_S13,coord+bc).b;
	float ds=decons;
	float3 d;
	d=float3(r1,g1,b1);
	c=clamp(lerp(c,d,ds),0.0,1.0);
	r1=COMPAT_TEXTURE(NTSC_S12,boord+rc).r;
	g1=COMPAT_TEXTURE(NTSC_S12,boord+gc).g;
	b1=COMPAT_TEXTURE(NTSC_S12,boord+bc).b;
	d=float3(r1,g1,b1);
	b=clamp(lerp(b,d,ds),0.0,1.0);
}

float4 EmptyPassPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	return COMPAT_TEXTURE(NTSC_S00,texcoord.xy);
}

float4 Signal_1_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float pix_res=min(ntsc_scale,1.0);
	float phase=(ntsc_phase<1.5)?((OrgSize.x>300.0)?2.0:3.0):((ntsc_phase>2.5)?3.0:2.0);
	float res=ntsc_scale;
	float CHROMA_MOD_FREQ=(phase<2.5)?(4.0*pii/15.0):(pii/3.0);
	float ARTIFACTING=(quality>-0.5)?quality:cust_artifacting;
	float FRINGING=(quality>-0.5)?quality:cust_fringing;
	float BRIGHTNESS=ntsc_bright;
	float SATURATION=ntsc_sat;
	float MERGE;
	MERGE=(int(quality)==2||phase<2.5)?0.0:1.0;
	MERGE=(int(quality)==-1)?ntsc_fields:MERGE;
	float2 pix_no=NTSC_01.xy*texcoord*pix_res;
	float3 col0=tex2D(NTSC_S01,texcoord).rgb;
	float3 yiq1=rgb2yiq(col0);
	float3 yiq2=yiq1;
	float3 yiqs=yiq1;
	float3 yiqz=yiq1;
	float lum=yiq1.x;
	float mod1=2.0;
	float mod2=3.0;
	if(MERGE>0.5)
	{
	float chroma_phase2=(phase<2.5)?pii*(mod(pix_no.y,mod1)+mod(framecount+1,2.)):0.6667*pii*(mod(pix_no.y,mod2)+mod(framecount+1,2.));
	float mod_phase2=chroma_phase2+pix_no.x*CHROMA_MOD_FREQ;
	float i_mod2=cos(mod_phase2);
	float q_mod2=sin(mod_phase2);
	yiq2.yz*=float2(i_mod2,q_mod2);
	yiq2=mul(mix_m,yiq2);
	yiq2.yz*=float2(i_mod2,q_mod2);
	if(res>1.025)
	{
	mod_phase2=chroma_phase2+pix_no.x*CHROMA_MOD_FREQ*res;
	i_mod2=cos(mod_phase2);
	q_mod2=sin(mod_phase2);
	yiqs.yz*=float2(i_mod2,q_mod2);
	yiq2.x=dot(yiqs,mix_m[0]);
	}
	}
	float chroma_phase1=(phase<2.5)?pii*(mod(pix_no.y,mod1)+mod(framecount,2.)):0.6667*pii*(mod(pix_no.y,mod2)+mod(framecount,2.));
	float mod_phase1=chroma_phase1+pix_no.x*CHROMA_MOD_FREQ;
	float i_mod=cos(mod_phase1);
	float q_mod=sin(mod_phase1);
	yiq1.yz*=float2(i_mod,q_mod);
	yiq1=mul(mix_m,yiq1);
	yiq1.yz*=float2(i_mod,q_mod);
	if(res>1.025)
	{
	mod_phase1=chroma_phase1+pix_no.x*CHROMA_MOD_FREQ*res;
	i_mod=cos(mod_phase1);
	q_mod=sin(mod_phase1);
	yiqz.yz*=float2(i_mod,q_mod);
	yiq1.x=dot(yiqz,mix_m[0]);
	}
	yiq1=(MERGE<0.5)?yiq1:0.5*(yiq1+yiq2);
	return float4(yiq1,lum);
}

float4 Signal_2_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	const float chroma_filter_2_phase[33]={
    0.001384762, 0.001678312, 0.002021715, 0.002420562, 0.002880460, 0.003406879, 0.004004985, 0.004679445, 0.005434218, 0.006272332, 0.007195654,
    0.008204665, 0.009298238, 0.010473450, 0.011725413, 0.013047155, 0.014429548, 0.015861306, 0.017329037, 0.018817382, 0.020309220, 0.021785952,
    0.023227857, 0.024614500, 0.025925203, 0.027139546, 0.028237893, 0.029201910, 0.030015081, 0.030663170, 0.031134640, 0.031420995, 0.031517031};
	const float chroma_filter_3_phase[25]={
   -0.000118847,-0.000271306,-0.000502642,-0.000930833,-0.001451013,
   -0.002064744,-0.002700432,-0.003241276,-0.003524948,-0.003350284,
   -0.002491729,-0.000721149, 0.002164659, 0.006313635, 0.011789103,
    0.018545660, 0.026414396, 0.035100710, 0.044196567, 0.053207202,
    0.061590275, 0.068803602, 0.074356193, 0.077856564, 0.079052396};
	const float luma_filter_2_phase[33]={
   -0.000174844,-0.000205844,-0.000149453,-0.000051693, 0.000000000,-0.000066171,-0.000245058,-0.000432928,-0.000472644,-0.000252236, 0.000198929,
    0.000687058, 0.000944112, 0.000803467, 0.000363199, 0.000013422, 0.000253402, 0.001339461, 0.002932972, 0.003983485, 0.003026683,-0.001102056,
   -0.008373026,-0.016897700,-0.022914480,-0.021642347,-0.008863273, 0.017271957, 0.054921920, 0.098342579, 0.139044281, 0.168055832, 0.178571429};
	const float luma_filter_3_phase[25]={
   -0.000012020,-0.000022146,-0.000013155,-0.000012020,-0.000049979,
   -0.000113940,-0.000122150,-0.000005612, 0.000170516, 0.000237199,
    0.000169640, 0.000285688, 0.000984574, 0.002018683, 0.002002275,
   -0.000909882,-0.007049081,-0.013222860,-0.012606931, 0.002460860,
    0.035868225, 0.084016453, 0.135563500, 0.175261268, 0.190176552};
	const int TAPS_2_phase=32;
	const int TAPS_3_phase=24;
	float3 signal=0.0;
	float res=ntsc_scale;
	float one=NTSC_01.z/res;
	float phase=(ntsc_phase<1.5)?((OrgSize.x>300.0)?2.0:3.0):((ntsc_phase>2.5)?3.0:2.0);
	if(phase<2.5){for(int i=0;i<TAPS_2_phase;i++)
	{
	float offset=float(i);
	float3 sums=fetch_offset(offset-float(TAPS_2_phase),one)+fetch_offset(float(TAPS_2_phase)-offset,one);
	signal+=sums*float3(luma_filter_2_phase[i],chroma_filter_2_phase[i],chroma_filter_2_phase[i]);
	}
	signal+=tex2D(NTSC_S02,tex_1).xyz*float3(luma_filter_2_phase[TAPS_2_phase],chroma_filter_2_phase[TAPS_2_phase],chroma_filter_2_phase[TAPS_2_phase]);}else
	if(phase>2.5){for(int i=0;i<TAPS_3_phase;i++)
	{
	float offset=float(i);
	float3 sums=fetch_offset(offset-float(TAPS_3_phase),one)+fetch_offset(float(TAPS_3_phase)-offset,one);
	signal+=sums*float3(luma_filter_3_phase[i],chroma_filter_3_phase[i],chroma_filter_3_phase[i]);
	}
	signal+=tex2D(NTSC_S02,tex_1).xyz*float3(luma_filter_3_phase[TAPS_3_phase],chroma_filter_3_phase[TAPS_3_phase],chroma_filter_3_phase[TAPS_3_phase]);}
	if(ntsc_ring>0.5)
	{
	float2 dx=float2(OrgSize.z/min(res,1.0),0.0);
	float a=tex2D(NTSC_S02,tex_1-1.5*dx).a;
	float b=tex2D(NTSC_S02,tex_1-0.5*dx).a;
	float c=tex2D(NTSC_S02,tex_1+1.5*dx).a;
	float d=tex2D(NTSC_S02,tex_1+0.5*dx).a;
	float e=tex2D(NTSC_S02,tex_1       ).a;
	signal.x=clamp(signal.x,min(min(min(a,b),min(c,d)),e),max(max(max(a,b),max(c,d)),e));
	}
	signal.x=clamp(signal.x,-1.0,1.0);
	float3 rgb=signal;
	return float4(rgb,1.0);
}

float4 Signal_3_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float2 tcoord=tex_2+float2(0.25*NTSC_02.z,0.0);
	float2 offset=float2(0.5*OrgSize.z,0.0);
	float3 ll1=tex2D(NTSC_S03,tcoord+     offset).xyz;
	float3 ll2=tex2D(NTSC_S03,tcoord-     offset).xyz;
	float3 ll3=tex2D(NTSC_S03,tcoord+0.50*offset).xyz;
	float3 ll4=tex2D(NTSC_S03,tcoord-0.50*offset).xyz;
	float3 ref=tex2D(NTSC_S03,tcoord).xyz;
	float lum1=tex2D(NTSC_S02,tex_2).a;
	float lum2=max(ref.x,0.0);
	float dif=max(max(abs(ll1.x-ll2.x),abs(ll1.y-ll2.y)),max(abs(ll1.z-ll2.z),abs(ll1.x*ll1.x-ll2.x*ll2.x)));
	float dff=max(max(abs(ll3.x-ll4.x),abs(ll3.y-ll4.y)),max(abs(ll3.z-ll4.z),abs(ll3.x*ll3.x-ll4.x*ll4.x)));
	float lc=(1.0-smoothstep(0.10,0.20,abs(lum2-lum1)))*pow(dff,0.125);
	float sweight=smoothstep(0.05-0.03*lc,0.45-0.40*lc,dif);
	float3 signal=ref;
	if(abs(ntsc_shrp)>-0.1)
	{
	float lummix=lerp(lum2,lum1,0.1*abs(ntsc_shrp));
	float lm1=lerp(lum2*lum2,lum1*lum1,0.1*abs(ntsc_shrp));lm1=sqrt(lm1);
	float lm2=lerp(sqrt(lum2),sqrt(lum1),0.1*abs(ntsc_shrp));lm2=lm2*lm2;
	float k1=abs(lummix-lm1)+0.00001;
	float k2=abs(lummix-lm2)+0.00001;
	lummix=min((k2*lm1+k1*lm2)/(k1+k2),1.0);
	signal.x=lerp(lum2,lummix,smoothstep(0.25,0.4,pow(dff,0.125)));
	signal.x=min(signal.x,max(ntsc_shpe*signal.x,lum2));
	}else
	signal.x=clamp(signal.x,-1.0,1.0);
	float3 rgb=signal;
	if(ntsc_shrp<-0.1)
	{
	rgb.x=lerp(ref.x,rgb.x,sweight);
	}
	rgb=clamp(yiq2rgb(rgb),0.0,1.0);
	if(blendMode<0.5)
	{
	float3 orig=tex2D(NTSC_S01,tex_2).rgb;
	rgb=normalize(rgb+0.00001)*min(length(rgb),length(orig));
	}
	return float4(rgb,1.0);
}

float4 SharpnessPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float2 g01=float2(-1.0,0.0)*OrgSize.zw;
	float2 g21=float2( 1.0,0.0)*OrgSize.zw;
	float3 c01=tex2D(NTSC_S04,texcoord+g01).rgb;
	float3 c21=tex2D(NTSC_S04,texcoord+g21).rgb;
	float3 c11=tex2D(NTSC_S04,texcoord    ).rgb;
	float3 b11=0.5*(c01+c21);
	float contrast=max(max(c11.r,c11.g),c11.b);
	contrast=lerp(2.0*CCONTR,CCONTR,contrast);
	float3 mn1=min(c01,c21);mn1=min(mn1,c11*(1.0-contrast));
	float3 mx1=max(c01,c21);mx1=max(mx1,c11*(1.0+contrast));
	float3 dif=pow(mx1-mn1+0.0001,0.75);
	float3 sharpen=lerp(CSHARPEN*CDETAILS,CSHARPEN,dif);
	c11=clamp(lerp(c11,b11,-sharpen),mn1,mx1);
	return float4(c11,1.0);
}

float4 LuminancePS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float m=max(log2(OrgSize.x),log2(OrgSize.y));
	m=floor(max(m,1.0))-1.0;
	float2 dx=float2(1.0/OrgSize.x,0.0);
	float2 dy=float2(0.0,1.0/OrgSize.y);
	float2 x2=2.0*dx;
	float2 y2=2.0*dy;
	float ltotal=0.0;
	ltotal+=length( tex2Dlod(NTSC_S05,float4(float2(0.3,0.3),m,0)).rgb);
	ltotal+=length( tex2Dlod(NTSC_S05,float4(float2(0.3,0.7),m,0)).rgb);
	ltotal+=length( tex2Dlod(NTSC_S05,float4(float2(0.7,0.3),m,0)).rgb);
	ltotal+=length( tex2Dlod(NTSC_S05,float4(float2(0.7,0.7),m,0)).rgb);
	ltotal*=0.25;
	ltotal=pow(0.577350269*ltotal,0.7);
	float lhistory=tex2D(NTSC_S06,0.5).a;
	ltotal=lerp(ltotal,lhistory,lsmooth);
	float3 l1=COMPAT_TEXTURE(NTSC_S05,texcoord.xy   ).rgb;
	float3 r1=COMPAT_TEXTURE(NTSC_S05,texcoord.xy+dx).rgb;
	float3 l2=COMPAT_TEXTURE(NTSC_S05,texcoord.xy-dx).rgb;
	float3 r2=COMPAT_TEXTURE(NTSC_S05,texcoord.xy+x2).rgb;
	float c1=dist(l2,l1);
	float c2=dist(l1,r1);
	float c3=dist(r2,r1);
	return float4(c1,c2,c3,ltotal);
}

float4 LinearizePS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float3 c1=tex2Dlod(NTSC_S05,float4(texcoord,0,0)).rgb;
	float3 c2=tex2Dlod(NTSC_S05,float4(texcoord+float2(0.0,OrgSize.w),0,0)).rgb;
	if((downsample_levelx+downsample_levely)>0.025)
	{
	c1=fetch_pixel(texcoord);
	c2=fetch_pixel(texcoord+float2(0.0,OrgSize.w));
	}
	float3 c=c1;
	float intera=1.0;
	float gamma_in=clamp(gamma_i,1.0,5.0);
	float m1=max(max(c1.r,c1.g),c1.b);
	float m2=max(max(c2.r,c2.g),c2.b);
	float3 df=abs(c1-c2);
	float d=max(max(df.r,df.g),df.b);
	if(interm==2.0)d=lerp(0.1*d,10.0*d,step(m1/(m2+0.0001),m2/(m1+0.0001)));
	float r=m1;
	float yres_div=1.0;if(intres>1.25)yres_div=intres;
	if(inter<=OrgSize.y/yres_div&&interm>0.5&&intres!=1.0&&intres!=0.5)
	{
	intera=0.25;
	float liine_no=clamp(floor( mod(OrgSize.y*texcoord.y,2.0)),0.0,1.0);
	float frame_no=clamp(floor( mod(float(framecount),2.0)),0.0,1.0);
	float ii=abs(liine_no-frame_no);
	if(interm< 3.5)
	{
	c2=plant(lerp(c2,c2*c2,iscans),max(max(c2.r,c2.g),c2.b));
	r=clamp(max(m1*ii,(1.0-iscan)*min(m1,m2)),0.0,1.0);
	c=plant(lerp(lerp(c1,c2,min(lerp(m1,1.0-m2,min(m1,1.0-m1))/(d+0.00001),1.0)),c1,ii),r);
	if(interm==3.0)c=(1.0-0.5*iscan)*lerp(c2,c1,ii);
	}
	if(interm==4.0){c=plant(lerp(c,c*c,0.5*iscans),max(max(c.r,c.g),c.b))*(1.0-0.5*iscan);}
	if(interm==5.0){c=lerp(c2,c1,0.5);c=plant(lerp(c,c*c,0.5*iscans),max(max(c.r,c.g),c.b))*(1.0-0.5*iscan);}
	}
	c=pow(c,gamma_in);
	if(texcoord.x>0.5){gamma_in=intera;}else{gamma_in=1.0/gamma_in;}
	return float4(c,gamma_in);
}

float4 HGaussianPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float4 GaussSize=float4(OrgSize.x,OrgSize.y,OrgSize.z,OrgSize.w);
	float f=frac(GaussSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(GaussSize.xy*texcoord)*GaussSize.zw+0.5*GaussSize.zw;
	float3 color=0.0;
	float2 dx=float2(GaussSize.z,0.0);
	float3 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEH;
	do
	{
	pixel=tex2Dlod(NTSC_S07, float4(tex+n*dx,0,0)).rgb;
	if(m_glow>0.5)
	{
	pixel=max(pixel-m_glow_cutoff,0.0);
	pixel=plant(pixel,max(max(max(pixel.r,pixel.g),pixel.b)-m_glow_cutoff,0.0));
	}
	w=gauss_h(n+f);
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}while(n<=SIZEH);
	color=color/wsum;
	return float4(color,1.0);
}

float4 VGaussianPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float4 GaussSize=float4(SrcSize.x,OrgSize.y,SrcSize.z,OrgSize.w);
	float f=frac(GaussSize.y*texcoord.y);
	f=0.5-f;
	float2 tex=floor(GaussSize.xy*texcoord)*GaussSize.zw+0.5*GaussSize.zw;
	float3 color=0.0;
	float2 dy=float2(0.0,GaussSize.w);
	float3 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEV;
	do
	{
	pixel=tex2Dlod(NTSC_S09, float4(tex+n*dy,0,0)).rgb;
	w=gauss_v(n+f);
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}while(n<=SIZEV);
	color=color/wsum;
	return float4(color,1.0);
}

float4 BloomHorzPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float4 BloomSize=float4(OrgSize.x,OrgSize.y,OrgSize.z,OrgSize.w);
	float f=frac(BloomSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(BloomSize.xy*texcoord)*BloomSize.zw+0.5*BloomSize.zw;
	float4 color=0.0;
	float2 dx=float2(BloomSize.z,0.0);
	float4 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEX;
	do
	{
	pixel=tex2Dlod(NTSC_S07, float4(tex+n*dx,0,0));
	w=max(gauss_x(n+f)-BLOOMCUT_X,0.0);
	pixel.a =max(max(pixel.r,pixel.g),pixel.b);
	pixel.a*=pixel.a*pixel.a;
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}while(n<=SIZEX);
	color=color/wsum;
	return float4(color.rgb,pow(color.a,0.333333));
}

float4 BloomVertPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float4 BloomSize=float4(SrcSize.x,OrgSize.y,SrcSize.z,OrgSize.w);
	float f=frac(BloomSize.y*texcoord.y);
	f=0.5-f;
	float2 tex=floor(BloomSize.xy*texcoord)*BloomSize.zw+0.5*BloomSize.zw;
	float4 color=0.0;
	float2 dy=float2(0.0,BloomSize.w);
	float4 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEY;
	do
	{
	pixel=tex2Dlod(NTSC_S11, float4(tex+n*dy,0,0));
	w=max(gauss_y(n+f)-BLOOMCUT_Y,0.0);
	pixel.a*=pixel.a*pixel.a;
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}while(n<=SIZEY);
	color=color/wsum;
	return float4(color.rgb,pow(color.a,0.175000));
}

float4 NTSC_TV1_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float2 prescalex=float2(tex2Dsize(NTSC_S07,0))/OrgSize.xy;
	float4 NTSCSize=OrgSize*float4(2.0*prescalex.x,prescalex.y,0.5/prescalex.x,1.0/prescalex.y);
	float f=frac(NTSCSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(NTSCSize.xy*texcoord)*NTSCSize.zw+0.5*NTSCSize.zw;
	float3 color=0.0.xxx;
	float scolor=0.0;
	float2 dx=float2(NTSCSize.z,0.0);
	float w=0.0;
	float swsum=0.0;
	float wsum=0.0;
	float3 pixel;
	float hsharpness=HSHARPNESS;
	float3 cmax=0.0.xxx;
	float3 cmin=1.0.xxx;
	float sharp=crthd_h(hsharpness)*S_SHARPH;
	float maxsharp=MAXS;
	float FPR=hsharpness;
	float fpx=0.0;
	float sp=0.0;
	float sw=0.0;
	float ts=0.025;
	float3 luma=float3(0.2126,0.7152,0.0722);
	float LOOPSIZE=ceil(2.0*FPR);
	float CLAMPSIZE=round(2.0*LOOPSIZE/3.0);
	float n=-LOOPSIZE;
	do
	{
	pixel=tex2Dlod(NTSC_S07, float4(tex+n*dx,0,0)).rgb;
	sp=max(max(pixel.r,pixel.g),pixel.b);
	w=crthd_h(n+f)-sharp;
	fpx=abs(n+f-sign(n)*FPR)/FPR;
	if(abs(n)<=CLAMPSIZE)cmax=max(cmax,pixel);cmin=min(cmin,pixel);
	if(w<0.0)w=clamp(w,lerp(-maxsharp,0.0,pow(clamp(fpx,0.0,1.0),HSHARP)),0.0);
	color=color+w*pixel;
	wsum=wsum+w;
	sw=max(w,0.0)*(dot(pixel,luma)+ts);
	scolor=scolor+sw*sp;
	swsum=swsum+sw;
	n=n+1.0;
	}while(n<=LOOPSIZE);
	color=color/wsum;
	scolor=scolor/swsum;
	color=clamp(lerp(clamp(color,cmin,cmax),color,HARNG),0.0,1.0);
	scolor=clamp(lerp(max(max(color.r,color.g),color.b),scolor,spike),0.0,1.0);
	return float4(color,scolor);
}

float4 NTSC_TV2_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float prescalex=tex2Dsize(NTSC_S07,0).x/(2.0*OrgSize.x);
	float4 NTSCSize=OrgSize*float4(prescalex,1.0,1.0/prescalex,1.0);
	float gamma_in=1.0/COMPAT_TEXTURE(NTSC_S07,0.25).a;
	float lum=COMPAT_TEXTURE(NTSC_S06,0.5).a;
	float intera=COMPAT_TEXTURE(NTSC_S07,float2(0.75,0.25)).a;
	bool interb=((intera<0.5)||(no_scanlines>0.025));
	NTSCSize*=float4(2.0,1.0,0.5,1.0);
	float SourceY=NTSCSize.y;
	float sy=1.0;
	if( intres==1.0)sy=SourceY/224.0;
	if( intres>0.25&&intres!=1.0)sy=intres;
	NTSCSize*=float4(1.0,1.0/sy,1.0,sy);
	if(IOS> 0.0&&!interb)
	{
	float2 ofactor=OptSize.xy/OrgSize.xy;
	float2 intfactor=(IOS<2.5)?floor(ofactor):ceil(ofactor);
	float2 diff=ofactor/intfactor;
	float scan=diff.y;
	texcoord=overscan(texcoord,scan,scan);
	if(IOS==1.0||IOS==3.0)texcoord=float2(texcoord.x,texcoord.y);
	}
	float factor=1.0+(1.0-0.5*OS)*blm_2/100.0-lum*blm_2/100.0;
	texcoord=overscan(texcoord,factor,factor);
	texcoord=overscan(texcoord,(OrgSize.x-overscanx)/OrgSize.x,(OrgSize.y-overscany)/OrgSize.y);
	float2 pos=warp(texcoord);
	float2 coffset=0.5;
	float2 ps=NTSCSize.zw;
	float2 OGL2Pos=pos*NTSCSize.xy-coffset;
	float2 fp=frac(OGL2Pos);
	float2 dx=float2(ps.x,0.0);
	float2 dy=float2(0.0,ps.y);
	float f=fp.y;
	float2 pC4=floor(OGL2Pos)*ps+0.5*ps;
	pC4.x=pos.x;
	if( intres==0.5&&prescalex<1.5)pC4.y=floor(pC4.y*OrgSize.y)*OrgSize.w+0.5*OrgSize.w;
	if( interb&&no_scanlines<0.025)pC4.y=pos.y;else
	if( interb)pC4.y=pC4.y+smoothstep(0.40-0.5*no_scanlines,0.60+0.5*no_scanlines,f)*NTSCSize.w;
	float3  color1=tex2Dlod(NTSC_S08,float4(pC4,0,0)).rgb;
	float3 scolor1=tex2Dlod(NTSC_S08,float4(pC4,0,0)).aaa;
	if(!interb)color1=pow(color1,scangamma/gamma_in);
	pC4+=dy;
	if( intres==0.5&&prescalex<1.5)pC4.y=floor((pos.y+0.33*dy.y)*OrgSize.y)*OrgSize.w+0.5*OrgSize.w;
	float3  color2=tex2Dlod(NTSC_S08,float4(pC4,0,0)).rgb;
	float3 scolor2=tex2Dlod(NTSC_S08,float4(pC4,0,0)).aaa;
	if(!interb)color2=pow(color2,scangamma/gamma_in);
	float3 ctmp=color1;float w3=1.0;float3 color=color1;
	if(!interb)
	{
	float shape1=lerp(scanline1,scanline2,    f);
	float shape2=lerp(scanline1,scanline2,1.0-f);
	float wt1=st0(    f);
	float wt2=st0(1.0-f);
	float3 color00= color1*wt1+ color2*wt2;
	float3 scolor0=scolor1*wt1+scolor2*wt2;
	ctmp=color00/(wt1+wt2);
	float3 sctmp=scolor0/(wt1+wt2);
	float wf1,wf2;
	float3 cref1=lerp(sctmp,scolor1,beam_size);float creff1=pow(max(max(cref1.r,cref1.g),cref1.b),scan_falloff);
	float3 cref2=lerp(sctmp,scolor2,beam_size);float creff2=pow(max(max(cref2.r,cref2.g),cref2.b),scan_falloff);
	float f1=    f;
	float f2=1.0-f;
	float scanpix=NTSCSize.x/OptSize.x;
	f1=frac(f1+rolling_scan*float(framecount)*scanpix);
	f2=1.0-f1;
	if(gsl< 0.5)
	{wf1=sw0(f1,creff1,shape1);wf2=sw0(f2,creff2,shape2);}else
	if(gsl==1.0)
	{wf1=sw1(f1,creff1,shape1);wf2=sw1(f2,creff2,shape2);}else
	{wf1=sw2(f1,creff1,shape1);wf2=sw2(f2,creff2,shape2);}
	if((wf1+wf2)>1.0){float wtmp=1.0/(wf1+wf2);wf1*=wtmp;wf2*=wtmp;}
	float3 w1=wf1;float3 w2=wf2;
	w3=wf1+wf2;
	float mc1=max(max(color1.r,color1.g),color1.b)+eps;
	float mc2=max(max(color2.r,color2.g),color2.b)+eps;
	cref1=color1/mc1;
	cref2=color2/mc2;
	float scanpow1=(scans>0.0)?1.0:pow(f1,0.375);
	float scanpow2=(scans>0.0)?1.0:pow(f2,0.375);
	w1=pow(w1,lerp(2.0*abs(scans).xxx+1.0,1.0.xxx,lerp(1.0.xxx,cref1,scanpow1)));
	w2=pow(w2,lerp(2.0*abs(scans).xxx+1.0,1.0.xxx,lerp(1.0.xxx,cref2,scanpow2)));
	color=(gc(color1)*w1+gc(color2)*w2);
	if(abs(rolling_scan)>0.005)
	{
	wt1=st1(    f);
	wt2=st1(1.0-f);
	color00=(color1*wt1+color2*wt2)/(wt1+wt2);
	color=gc(color00)*lerp(w1+w2,w3.xxx,max(wf1,wf2));
	}
	color=min(color,1.0);
	}
	if( interb)
	{
	color=gc(color1);
	}
	float colmx=max(max(ctmp.r,ctmp.g),ctmp.b);
	if(!interb)color=pow(color,gamma_in/scangamma);
	return float4(color,colmx);
}

float4 ChromaticPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float gamma_in=1.0/COMPAT_TEXTURE(NTSC_S07,0.25).a;
	float lum=COMPAT_TEXTURE(NTSC_S06,0.5).a;
	float intera=COMPAT_TEXTURE(NTSC_S07,float2(0.75,0.25)).a;
	bool interb=(intera<0.5||no_scanlines>0.025);
	if(IOS> 0.0&&!interb)
	{
	float2 ofactor=OptSize.xy/OrgSize.xy;
	float2 intfactor=(IOS<2.5)?floor(ofactor):ceil(ofactor);
	float2 diff=ofactor/intfactor;
	float scan=diff.y;
	texcoord=overscan(texcoord,scan,scan);
	if(IOS==1.0||IOS==3.0)texcoord=float2(texcoord.x,texcoord.y);
	}
	float factor=1.0+(1.0-0.5*OS)*blm_2/100.0-lum*blm_2/100.0;
	texcoord=overscan(texcoord,factor,factor);
	texcoord=overscan(texcoord,(OrgSize.x-overscanx)/OrgSize.x,(OrgSize.y-overscany)/OrgSize.y);
	float2 pos0=warp(texcoord.xy);
	float2 pos1=texcoord.xy;
	float2 pos=warp(texcoord);
	float3 color=COMPAT_TEXTURE(NTSC_S13,pos1).rgb;
	float3 Bloom=COMPAT_TEXTURE(NTSC_S12,pos ).rgb;
	if((abs(deconrx)+abs(deconry)+abs(decongx)+abs(decongy)+abs(deconbx)+abs(deconby))>0.2)
	bring_pixel(color,Bloom,pos1,pos);
	float cm=igc(max(max(color.r,color.g),color.b));
	float mx1=COMPAT_TEXTURE(NTSC_S13,pos1   ).a;
	float colmx=max(mx1,cm);
	float w3=min((cm+0.0001)/(colmx+0.0005),1.0);
	float2 dx=float2(0.001,0.0);
	float mx0=COMPAT_TEXTURE(NTSC_S13,pos1-dx).a;
	float mx2=COMPAT_TEXTURE(NTSC_S13,pos1+dx).a;
	float mxg=max(max(mx0,mx1),max(mx2,cm));
	float mx=pow(mxg,1.40/gamma_in);
	dx=float2(OrgSize.z,0.0)*0.25;
	mx0=COMPAT_TEXTURE(NTSC_S13,pos1-dx).a;
	mx2=COMPAT_TEXTURE(NTSC_S13,pos1+dx).a;
	float mb=1.0-min(abs(mx0-mx2)/(0.5+mx1),1.0);
	float3 orig1=color;
	float3 one=1.0;
	float3 cmask=one;
	float2 maskcoord=FragCoord.xy*1.00001;
	float2 scoord=maskcoord;
	float mwidths[15]={0.0,2.0,3.0,3.0,3.0,6.0,2.4,3.5,2.4,3.25,3.5,4.5,4.25,7.5,6.25};
	float mwidth=mwidths[int(shadow_msk)];
	float mask_compensate=frac(mwidth);
	mwidth=floor(mwidth)*masksize;
	float swidth=mwidth;
	bool zoomed=(abs(mask_zoom)>0.75);
	float mscale=1.0;
	float2 maskcoord0=maskcoord;
	maskcoord.y=floor(maskcoord.y/masksize);
	if(abs(mshift)>0.75)
	{
	float stagg_lvl=1.0;if(frac(abs(mshift))>0.25&&abs(mshift)>1.25)stagg_lvl=2.0;
	float next_line=float(frac((maskcoord.y/stagg_lvl)*0.5)>0.25);
	maskcoord0.x=(mshift>-0.25)?(maskcoord0.x+next_line*floor(mshift)):(maskcoord0.x+floor(maskcoord.y/stagg_lvl)*floor(abs(mshift)));
	}
	maskcoord=maskcoord0/masksize;if(mask_zoom>=0.0)maskcoord=floor(maskcoord);
	if(!zoomed) cmask*=crt_mask(maskcoord,mx,mb);else
	{
	float mwidth1=max(mwidth+mask_zoom,2.0);
	mscale=mwidth1/mwidth;
	float  mlerp= frac(maskcoord.x/mscale);
	float mcoord=floor(maskcoord.x/mscale); if(shadow_msk==13.0&&mask_zoom==-2.0)mcoord=ceil(maskcoord.x/mscale);
	cmask*=lerp(crt_mask(float2(mcoord,maskcoord.y),mx,mb),crt_mask(float2(mcoord+1.0,maskcoord.y),mx,mb),mlerp);
	}
	if(slotwidth>0.5)swidth=slotwidth;float smask=1.0;
	float sm_offset=0.0;bool bsm_offset=(shadow_msk==1.0||shadow_msk==3.0||shadow_msk==6.0||shadow_msk==7.0||shadow_msk==9.0||shadow_msk==12.0);
	if( zoomed)
	{
	if(mask_layout<0.5&&bsm_offset)sm_offset=1.0;else
	if(bsm_offset)sm_offset=-1.0;
	}
	swidth=round(swidth*mscale);
	smask=slt_mask(scoord+float2(sm_offset,0.0),mx,swidth);
	smask=clamp(smask+lerp(smask_mit,0.0,min(w3,pow(w3*max(max(orig1.r,orig1.g),orig1.b),0.33333))),0.0,1.0);
	cmask*=smask;
	float3 cmask1=cmask;
	if(mask_bloom>0.025)
	{
	float maxbl=max(max(max(Bloom.r,Bloom.g),Bloom.b),mxg);
	maxbl=maxbl*lerp(1.0,2.0-colmx,bloom_dist);
	cmask=max(min(cmask+maxbl*mask_bloom,1.0),cmask);
	}
	color=pow(color,mask_gamma/gamma_in);
	color=color*cmask;
	color=min(color,1.0);
	color=pow(color,gamma_in/mask_gamma);
	cmask=min(cmask,1.0);
	cmask1=min(cmask1,1.0);
	float dark_compensate=lerp(max(clamp(lerp(mcut,maskstr,mx),0.0,1.0)-1.0+mask_compensate,0.0)+1.0,1.0,mx);
	float bb=lerp(brightboost1,brightboost2,mx)*dark_compensate;
	color*=bb;
	float3 Glow=COMPAT_TEXTURE(NTSC_S10,pos).rgb;
	float3 Ref=COMPAT_TEXTURE(NTSC_S07,pos).rgb;
	float maxb=COMPAT_TEXTURE(NTSC_S12,pos).a;
	float3 Bloom1=Bloom;
	if(abs(blm_1)>0.025)
	{
	if(blm_1<-0.01)Bloom1=plant(Bloom,maxb);
	Bloom1=min(Bloom1*(orig1+color),max(0.5*(colmx+orig1-color),0.001*Bloom1));
	Bloom1=0.5*(Bloom1+lerp(Bloom1,lerp(colmx*orig1,Bloom1,0.5),1.0-color));
	Bloom1=Bloom1*lerp(1.0,2.0-colmx,bloom_dist);
	color=pow(pow(color,mask_gamma/gamma_in)+abs(blm_1)*pow(Bloom1,mask_gamma/gamma_in),gamma_in/mask_gamma);
	}
	color=min(color,lerp(one,cmask1,mclip));
	if(!interb)color=declip(color,lerp(1.0,w3,0.6));else
	{
	w3=1.0;
	}
	if(halation> 0.01)
	{
	Bloom=lerp(0.5*(Bloom+Bloom*Bloom),0.75*Bloom*Bloom,colmx);
	color=color+2.0*max((2.0*lerp(maxb*maxb,maxb,colmx)-0.5*max(max(Ref.r,Ref.g),Ref.b)),0.25)*lerp(1.0,w3,0.5*colmx)*lerp(one,cmask,0.6)*Bloom*halation;
	}else
	if(halation<-0.01)
	{
	float mbl=max(max(Bloom.r,Bloom.g),Bloom.b);
	Bloom=plant(Bloom+Ref+orig1+Bloom*Bloom*Bloom,min(mbl*mbl,0.75));
	color=color+2.0*lerp(1.0,w3,0.5*colmx)*lerp(one,cmask,0.5)*Bloom*(-halation);
	}
	float w=0.25+0.60*lerp(w3,1.0,sqrt(colmx));
	if(smoothmask>0.5)
	{
	w3=lerp(1.0,w3,smoothstep(0.3,0.6,mx1));color=max(min(color/w3,1.0)*w3,min(color,color*(1.0-w3)));
	}
	if(m_glow<0.5)Glow=lerp(Glow,0.25*color,0.7*colmx);else
	{
	maxb=max(max(Glow.r,Glow.g),Glow.b);
	orig1=plant(orig1+0.001*Ref,1.0);
	Bloom=plant(Glow,1.0);
	Ref=abs(orig1-Bloom);
	mx0=max(max(orig1.g,orig1.g),orig1.b)-min(min(orig1.g,orig1.g),orig1.b);
	mx2=max(max(Bloom.g,Bloom.g),Bloom.b)-min(min(Bloom.g,Bloom.g),Bloom.b);
	Bloom=lerp(maxb*min(Bloom,orig1),w*lerp(lerp(Glow,max(max(Ref.g,Ref.g),Ref.b)*Glow,max(mx,mx0)),lerp(color,Glow,mx2),max(mx0,mx2)*Ref),min(sqrt((1.10-mx0)*(0.10+mx2)),1.0));
	Glow=lerp(m_glow_low*Glow,m_glow_high*Bloom,pow(colmx,m_glow_dist/gamma_in));
	}
	if(glow>=0.0&&m_glow<0.5)color=color+0.5*Glow*glow;else
	{
	if(m_glow>0.5)cmask1=max(lerp(one,cmask1,m_glow_mask),0.0);color=color+abs(glow)*cmask1*Glow;
	}
	float vig=vignette(pos);
	color=min(color,1.0);
	color=pow(color,1.0/gamma_o);
	float rc=0.6*sqrt(max(max(color.r,color.g),color.b))+0.4;
	if(abs(addnoised)>0.01)
	{
	float3 noise0=noise(float3(floor(OptSize.xy*texcoord/noiseresd),float(framecount)));
	if(noisetype<0.5)color=lerp(color,noise0,0.25*abs(addnoised)*rc);else
	color=min(color*lerp(1.0,1.5*noise0.x,0.5*abs(addnoised)),1.0);
	}
	return float4(color*vig*humbars(lerp(pos.y,pos.x,bardir))*post_br*corner(pos0),1.0);
}

technique CRT_Guest_NTSC
{
	pass EmptyPass
	{
	VertexShader=PostProcessVS;
	PixelShader=EmptyPassPS;
	RenderTarget=NTSC_T01;
	}
	pass NTSCPASS1
	{
	VertexShader=PostProcessVS;
	PixelShader=Signal_1_PS;
	RenderTarget=NTSC_T02;
	}
	pass NTSCPASS2
	{
	VertexShader=PostProcessVS;
	PixelShader=Signal_2_PS;
	RenderTarget=NTSC_T03;
	}
	pass NTSCPASS3
	{
	VertexShader=PostProcessVS;
	PixelShader=Signal_3_PS;
	RenderTarget=NTSC_T04;
	}
	pass Sharpness
	{
	VertexShader=PostProcessVS;
	PixelShader=SharpnessPS;
	RenderTarget=NTSC_T05;
	}
	pass Luminance
	{
	VertexShader=PostProcessVS;
	PixelShader=LuminancePS;
	RenderTarget=NTSC_T06;
	}
	pass Linearize
	{
	VertexShader=PostProcessVS;
	PixelShader=LinearizePS;
	RenderTarget=NTSC_T07;
	}
	pass CRT_Pass1
	{
	VertexShader=PostProcessVS;
	PixelShader=NTSC_TV1_PS;
	RenderTarget=NTSC_T08;
	}
	pass GaussianX
	{
	VertexShader=PostProcessVS;
	PixelShader=HGaussianPS;
	RenderTarget=NTSC_T09;
	}
	pass GaussianY
	{
	VertexShader=PostProcessVS;
	PixelShader=VGaussianPS;
	RenderTarget=NTSC_T10;
	}
	pass BloomHorz
	{
	VertexShader=PostProcessVS;
	PixelShader=BloomHorzPS;
	RenderTarget=NTSC_T11;
	}
	pass BloomVert
	{
	VertexShader=PostProcessVS;
	PixelShader=BloomVertPS;
	RenderTarget=NTSC_T12;
	}
	pass CRT_Pass2
	{
	VertexShader=PostProcessVS;
	PixelShader=NTSC_TV2_PS;
	RenderTarget=NTSC_T13;
	}
	pass Chromatic
	{
	VertexShader=PostProcessVS;
	PixelShader=ChromaticPS;
	}
}