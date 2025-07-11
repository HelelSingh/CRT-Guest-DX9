/*

	CRT - Guest - NTSC

	Copyright (C) 2018-2025 guest(r)

	Incorporates many good ideas and suggestions from Dr. Venom.

	I would also like give thanks to many Libretro forums members for continuous feedback, suggestions and using the shader.

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
	without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along with this program; if not,
	write to the Free Software Foundation, Inc, 59 Temple Place - STE 330, Boston, MA 02111-1307, USA.

	Ported to ReShade by DevilSingh with some help from guest(r)

*/

uniform float internal_res <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 8.0;
	ui_step = 0.1;
	ui_label = "Internal Resolution";
> = 1.0;

uniform float cust_artifacting <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "NTSC Custom Artifacting Value";
> = 1.0;

uniform float cust_fringing <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "NTSC Custom Fringing Value";
> = 1.0;

uniform float ntsc_fields <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 3.0;
	ui_step = 1.0;
	ui_label = "NTSC Merge Fields: Auto | No | Yes";
> = 1.0;

uniform float ntsc_phase <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 4.0;
	ui_step = 1.0;
	ui_label = "NTSC Phase: Auto | 2 Phase | 3 Phase | Mixed";
> = 1.0;

uniform float ntsc_scale <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 2.5;
	ui_step = 0.025;
	ui_label = "NTSC Resolution Scaling";
> = 1.0;

uniform float ntsc_taps <
	ui_type = "drag";
	ui_min = 6.0;
	ui_max = 32.0;
	ui_step = 1.0;
	ui_label = "NTSC # of Taps (Filter Width)";
> = 32.0;

uniform float ntsc_cscale1 <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 4.00;
	ui_step = 0.05;
	ui_label = "NTSC Chroma Scaling/Bleeding (2 Phase)";
> = 1.0;

uniform float ntsc_cscale2 <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 2.25;
	ui_step = 0.05;
	ui_label = "NTSC Chroma Scaling/Bleeding (3 Phase)";
> = 1.0;

uniform float ntsc_sat <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.01;
	ui_label = "NTSC Color Saturation";
> = 1.0;

uniform float ntsc_brt <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.5;
	ui_step = 0.01;
	ui_label = "NTSC Brightness";
> = 1.0;

uniform float ntsc_gamma <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 2.5;
	ui_step = 0.025;
	ui_label = "NTSC Filtering Gamma Correction";
> = 1.0;

uniform float ntsc_rainbow <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 1.0;
	ui_label = "NTSC Coloring/Rainbow Effect (2 Phase)";
> = 0.0;

uniform float ntsc_ring <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.1;
	ui_label = "NTSC Anti-Ringing";
> = 0.5;

uniform float ntsc_shrp <
	ui_type = "drag";
	ui_min = -10.0;
	ui_max = 10.0;
	ui_step = 0.5;
	ui_label = "NTSC Sharpness (Adaptive)";
> = 0.0;

uniform float ntsc_shpe <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "NTSC Sharpness Shape";
> = 0.8;

uniform float ntsc_charp1 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 10.0;
	ui_step = 0.5;
	ui_label = "NTSC Preserve 'Edge' Colors (2 Phase)";
> = 0.0;

uniform float ntsc_charp2 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 10.0;
	ui_step = 0.5;
	ui_label = "NTSC Preserve 'Edge' Colors (3 Phase)";
> = 0.0;

uniform float CSHARPEN <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 5.0;
	ui_step = 0.1;
	ui_label = "FSharpen - Sharpen Strength";
> = 0.0;

uniform float CCONTR <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.25;
	ui_step = 0.01;
	ui_label = "FSharpen - Sharpen (+ Deblur) Contrast";
> = 0.05;

uniform float CDETAILS <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "FSharpen - Sharpen Details";
> = 1.0;

uniform float DEBLUR <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 7.0;
	ui_step = 0.25;
	ui_label = "FSharpen - Deblur Strength";
> = 1.0;

uniform float DREDGE <
	ui_type = "drag";
	ui_min = 0.7;
	ui_max = 1.0;
	ui_step = 0.01;
	ui_label = "FSharpen - Deblur Edges Falloff";
> = 0.9;

uniform float DSHARP <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 4.0;
	ui_step = 0.2;
	ui_label = "FSharpen - Deblur Extra Sharpen";
> = 0.0;

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

uniform float interr <
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
> = 4.0;

uniform float iscanb <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Interlacing Scanlines Effect (Interlaced Brightness)";
> = 0.2;

uniform float iscans <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Interlacing Scanlines Saturation";
> = 0.25;

uniform float hiscan <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "High Resolution Scanlines (Prepend A Scaler)";
> = 0.0;

uniform float intres <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 10.0;
	ui_step = 0.5;
	ui_label = "Internal Resolution Y: 0.5 | Y-Dowsample";
> = 0.0;

uniform float downsample_levelx <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Downsampling-X (High-Res Content, Pre-Scalers)";
> = 0.0;

uniform float downsample_levely <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Downsampling-Y (High-Res Content, Pre-Scalers)";
> = 0.0;

uniform float HSHARPNESS <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 8.0;
	ui_step = 0.05;
	ui_label = "Horizontal Filter Range";
> = 1.6;

uniform float LIGMA_H <
	ui_type = "drag";
	ui_min = 0.1;
	ui_max = 7.0;
	ui_step = 0.025;
	ui_label = "Horizontal Blur Sigma";
> = 0.8;

uniform float S_SHARP <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 3.0;
	ui_step = 0.05;
	ui_label = "Substractive Sharpness";
> = 1.1;

uniform float SHARP <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.1;
	ui_label = "Sharpness Definition";
> = 1.2;

uniform float MAXS <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.3;
	ui_step = 0.01;
	ui_label = "Maximum Sharpness";
> = 0.18;

uniform float SSRNG <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 4.0;
	ui_step = 0.05;
	ui_label = "Substractive Sharpness Ringing";
> = 0.3;

uniform float m_glow <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
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
	ui_step = 0.1;
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

uniform float FINE_GAUSS <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 5.0;
	ui_step = 1.0;
	ui_label = "Fine (Magic) Glow Sampling";
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
	ui_step = 0.05;
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
	ui_step = 0.05;
	ui_label = "Vertical Glow Sigma";
> = 1.2;

uniform float FINE_BLOOM <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 5.0;
	ui_step = 1.0;
	ui_label = "Fine Bloom/Halation Sampling";
> = 1.0;

uniform float SIZEX <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 50.0;
	ui_step = 1.0;
	ui_label = "Horizontal Bloom/Halation Radius";
> = 3.0;

uniform float SIGMA_X <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 15.0;
	ui_step = 0.025;
	ui_label = "Horizontal Bloom/Halation Sigma";
> = 0.75;

uniform float SIZEY <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 50.0;
	ui_step = 1.0;
	ui_label = "Vertical Bloom/Halation Radius";
> = 3.0;

uniform float SIGMA_Y <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 15.0;
	ui_step = 0.025;
	ui_label = "Vertical Bloom/Halation Sigma";
> = 0.60;

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

uniform float b_mask <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "Bloom Mask Strength";
> = 0.0;

uniform float mask_bloom <
	ui_type = "drag";
	ui_min = -2.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Mask Bloom";
> = 0.0;

uniform float bloom_dist <
	ui_type = "drag";
	ui_min = -2.0;
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

uniform float h_mask <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "Halation Mask Strength";
> = 0.5;

uniform float gamma_c <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 2.0;
	ui_step = 0.025;
	ui_label = "Gamma Correct";
> = 1.0;

uniform float gamma_d <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 2.0;
	ui_step = 0.025;
	ui_label = "Complementary Gamma Correct";
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

uniform float clp <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Clip Saturated Color Beams";
> = 0.0;

uniform float gsl <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 2.0;
	ui_step = 1.0;
	ui_label = "Scanlines Type";
> = 0.0;

uniform float scanline1 <
	ui_type = "drag";
	ui_min = -20.0;
	ui_max = 40.0;
	ui_step = 0.5;
	ui_label = "Scanlines Beam Shape Center";
> = 6.0;

uniform float scanline2 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 70.0;
	ui_step = 1.0;
	ui_label = "Scanlines Beam Shape Edges";
> = 8.0;

uniform float beam_min <
	ui_type = "drag";
	ui_min = 0.25;
	ui_max = 10.0;
	ui_step = 0.05;
	ui_label = "Scanlines Shape Dark Pixels";
> = 1.3;

uniform float beam_max <
	ui_type = "drag";
	ui_min = 0.2;
	ui_max = 3.5;
	ui_step = 0.025;
	ui_label = "Scanlines Shape Bright Pixels";
> = 1.0;

uniform float tds <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Thinner Dark Scanlines";
> = 0.0;

uniform float beam_size <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Increased Bright Scanlines Beam";
> = 0.6;

uniform float scans <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 6.0;
	ui_step = 0.1;
	ui_label = "Scanlines Saturation / Mask Falloff";
> = 0.5;

uniform float scan_falloff <
	ui_type = "drag";
	ui_min = 0.1;
	ui_max = 2.0;
	ui_step = 0.025;
	ui_label = "Scanlines Falloff";
> = 1.0;

uniform float spike <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.1;
	ui_label = "Scanlines Spike Removal";
> = 1.0;

uniform float scangamma <
	ui_type = "drag";
	ui_min = 0.5;
	ui_max = 5.0;
	ui_step = 0.05;
	ui_label = "Scanlines Gamma";
> = 2.4;

uniform float rolling_scan <
	ui_type = "drag";
	ui_min = -1.0;
	ui_max = 1.0;
	ui_step = 0.01;
	ui_label = "Rolling Scanlines";
> = 0.0;

uniform float no_scanlines <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.5;
	ui_step = 0.05;
	ui_label = "No-Scanlines Mode";
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
	ui_max = 0.35;
	ui_step = 0.01;
	ui_label = "Corner Size";
> = 0.0;

uniform float bsize <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.01;
	ui_label = "Border Size";
> = 0.0;

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
	ui_label = "CRT Mask: 1:CGWG | 2-5:Lottes | 6-14:Trinitron";
> = 1.0;

uniform float maskstr <
	ui_type = "drag";
	ui_min = -0.5;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "Mask Strength (1, 6-14)";
> = 0.3;

uniform float mcut <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.05;
	ui_label = "Mask 6-14 Low Strength";
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
	ui_min = -10.0;
	ui_max = 6.0;
	ui_step = 1.0;
	ui_label = "CRT Mask Zoom (+ Mask Width)";
> = 0.0;

uniform float zoom_mask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "CRT Mask Zoom Sharpen";
> = 0.0;

uniform float mshift <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.5;
	ui_label = "(Transform to) Shadow Mask";
> = 0.0;

uniform float mask_layout <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 1.0;
	ui_label = "Mask Layout: RGB or BGR (Check LCD Panel)";
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
	ui_label = "Lottes Mask Bright";
> = 1.5;

uniform float mask_gamma <
	ui_type = "drag";
	ui_min = 1.0;
	ui_max = 5.0;
	ui_step = 0.05;
	ui_label = "Mask Gamma";
> = 2.4;

uniform float slotmask1 <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Slot Mask Strength Bright Pixels";
> = 0.0;

uniform float slotmask2 <
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

uniform float smoothmask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 2.0;
	ui_step = 0.25;
	ui_label = "Smooth Masks In Bright Scanlines";
> = 0.0;

uniform float smask_mit <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Mitigate Slot Mask Interaction";
> = 0.0;

uniform float bmask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 0.25;
	ui_step = 0.01;
	ui_label = "Base (Black) Mask Strength";
> = 0.0;

uniform float mclip <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "Preserve Mask Strength";
> = 0.0;

uniform float pr_scan <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.025;
	ui_label = "Preserve Scanlines Strength";
> = 0.1;

uniform float maskmid <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.05;
	ui_label = "Mitigate Mask on Mid-Colors";
> = 0.0;

uniform float edgemask <
	ui_type = "drag";
	ui_min = 0.0;
	ui_max = 1.0;
	ui_step = 0.1;
	ui_label = "Mitigate Mask on Edges";
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
	ui_label = "Horizontal Deconvergence 'R' Range";
> = 0.0;

uniform float decongx <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Horizontal Deconvergence 'G' Range";
> = 0.0;

uniform float deconbx <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Horizontal Deconvergence 'B' Range";
> = 0.0;

uniform float deconry <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Vertical Deconvergence 'R' Range";
> = 0.0;

uniform float decongy <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Vertical Deconvergence 'G' Range";
> = 0.0;

uniform float deconby <
	ui_type = "drag";
	ui_min = -15.0;
	ui_max = 15.0;
	ui_step = 0.25;
	ui_label = "Vertical Deconvergence 'B' Range";
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

#define TexSize float2(Resolution_X,Resolution_Y)
#define IptSize float2(800.00000000,600.00000000)
#define OptSize float4(BUFFER_SCREEN_SIZE,1.0/BUFFER_SCREEN_SIZE)
#define OrgSize float4(TexSize,1.0/TexSize)
#define SrcSize float4(IptSize,1.0/IptSize)
#define fuxcoord (texcoord*1.00001)
#define scans 1.5*scans
#define eps 1e-8
#define pii 3.14159265
#define fracoord (fuxcoord*OptSize.xy)
#define texCD(c,d) tex2Dlod(c,float4(d,0,0))
#define LumSize float4(2.0*TexSize.x,1.0*TexSize.y,1.0/(2.0*TexSize.x),1.0/(1.0*TexSize.y))
#define mix_m float3x3(BRIGHTNESS,ARTIFACT,ARTIFACT,FRINGING,2.0*SATURATION,0.0,FRINGING,0.0,2.0*SATURATION)
#define rgb_m float3x3(0.299,0.587,0.114,0.596,-0.274,-0.322,0.211,-0.523,0.312)
#define yiq_m float3x3(1.000,0.956,0.621,1.000,-0.272,-0.647,1.000,-1.106,1.703)
#define fetch_offset1(dx)  texCD(NTSC_S02,tex_c+dx).xyz+texCD(NTSC_S02,tex_c-dx).xyz
#define fetch_offset2(dx) float3(texCD(NTSC_S02,tex_c+dx.xz).x+texCD(NTSC_S02,tex_c-dx.xz).x,texCD(NTSC_S02,tex_c+dx.yz).yz+texCD(NTSC_S02,tex_c-dx.yz).yz)

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
sampler NTSC_S02{Texture=NTSC_T02;AddressU=BORDER;AddressV=BORDER;AddressW=BORDER;MagFilter=LINEAR;MinFilter=LINEAR;MipFilter=LINEAR;};

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

texture NTSC_T09{Width=1.0*800.00000000;Height=Resolution_Y ;Format=RGBA16F;};
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

float vignette(float2 pos)
{
	float2 b=vigdef*float2(1.0,OrgSize.x/OrgSize.y)*0.125;
	pos=clamp(pos,0.0,1.0);
	pos=abs(2.0*(pos-0.5));
	float2 res=lerp(0.0.xx,1.0.xx,smoothstep(1.0.xx,1.0.xx-b,sqrt(pos)));
	res=pow(res,0.70.xx);
	return max(lerp(1.0,sqrt(res.x*res.y),vigstr),0.0);
}

float dist(float3 A,float3 B)
{
	float r=0.5*(A.r+B.r);
	float3 d=A-B;
	float3 c=float3(2.+r,4.,3.-r);
	return sqrt(dot(c*d,d))/3.;
}

float3 plant(float3 tar,float r)
{
	float t=max(max(tar.r,tar.g),tar.b)+0.00001;
	return tar*r/t;
}

float3 fetch_pixel(float2 coord)
{
	float2 dx=float2(LumSize.z,0.0)*downsample_levelx;
	float2 dy=float2(0.0,LumSize.w)*downsample_levely;
	float2 d1=dx+dy;
	float2 d2=dx-dy;
	float sum=15.0;
	float3 result=
	3.0*texCD(NTSC_S05,coord   ).rgb+2.0*texCD(NTSC_S05,coord+dx).rgb+2.0*texCD(NTSC_S05,coord-dx).rgb+
	2.0*texCD(NTSC_S05,coord+dy).rgb+2.0*texCD(NTSC_S05,coord-dy).rgb+    texCD(NTSC_S05,coord+d1).rgb+
		texCD(NTSC_S05,coord-d1).rgb+    texCD(NTSC_S05,coord+d2).rgb+    texCD(NTSC_S05,coord-d2).rgb;
	return result/sum;
}

float gauss_h(float x)
{
	float sigma=1.0/(2.0*SIGMA_H*SIGMA_H);
	return exp(-x*x*sigma);
}

float gauss_v(float x)
{
	float sigma=1.0/(2.0*SIGMA_V*SIGMA_V);
	return exp(-x*x*sigma);
}

float bloom_h(float x)
{
	float sigma=1.0/(2.0*SIGMA_X*SIGMA_X);
	return exp(-x*x*sigma);
}

float bloom_v(float x)
{
	float sigma=1.0/(2.0*SIGMA_Y*SIGMA_Y);
	return exp(-x*x*sigma);
}

float crthd_h(float x,float y)
{
	float sigma=1.0/(2.0*LIGMA_H*LIGMA_H*y*y*internal_res*internal_res);
	return exp(-x*x*sigma);
}

float mod(float x,float y)
{
	return x-y* floor(x/y);
}

float st0(float x)
{
	return exp2(-10.0*x*x);
}

float3 sw0(float x,float color,float scanline,float3 c)
{
	float3 xe=lerp(1.0.xxx+scans,1.0.xxx,c);
	float tmp=lerp(beam_min,beam_max,color);
	float ex=x*tmp;
	ex=(gsl>-0.5)?ex*ex:lerp(ex*ex,ex*ex*ex,0.4);
	return exp2(-scanline*ex*xe);
}

float3 sw1(float x,float color,float scanline,float3 c)
{
	float3 xe=lerp(1.0.xxx+scans,1.0.xxx,c);
	x=lerp(x,beam_min*x,max(x-0.4*color,0.0));
	float tmp=lerp(1.2*beam_min,beam_max,color);
	float ex=x*tmp;
	return exp2(-scanline*ex*ex*xe);
}

float3 sw2(float x,float color,float scanline,float3 c)
{
	float3 xe=lerp(1.0.xxx+scans,1.0.xxx,c);
	float tmp=lerp((2.5-0.5*color)*beam_min,beam_max,color);
	tmp=lerp(beam_max,tmp,pow(x,color+0.3));
	float ex=x*tmp;
	return exp2(-scanline*ex*ex*xe);
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

float3 gc1(float3 c)
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

float get_luma(float3 c)
{
	return dot(c,float3(0.299,0.587,0.114));
}

float swoothstep(float e0,float e1,float x)
{
	return clamp((x-e0)/(e1-e0),0.0,1.0);
}

float3 crt_mask(float2 pos,float mx,float mb)
{
	float3 mask=mask_drk;
	float3 one=1.0;
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
	float lane=mask_lgt;
	float odd=0.0;
	if(frac(pos.x/6.0)<0.49)odd=1.0;
	if(frac((pos.y+odd)/2.0)<0.49)lane=mask_drk;
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=mask_lgt;else
	if(pos.x<1.5)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	mask*=lane;
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
	if  ((slotmask1+slotmask2)==0.0)return 1.0;else
	{
	pos.y=floor(pos.y/slotms);
	float mlen=swidth*2.0;
	float px=floor( mod(pos.x, 0.99999*mlen));
	float py=floor(frac(pos.y/(2.0*double_slot))*2.0*double_slot);
	float slot_dark=lerp(1.0-slotmask2,1.0-slotmask1,m);
	float slot=1.0;
	if(py==0.0&&px<swidth) slot=slot_dark;else
	if(py==double_slot&&px>=swidth) slot=slot_dark;
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
	pos=abs(2.0*(pos-0.50));
	float2 aspect=float2(1.0,OptSize.x/OptSize.y);
	float b=bsize*0.05+0.0005;pos.y=pos.y+b*(aspect.y-1.0);
	float2 crn=max(csize.xx,2.0*b+0.0015);
	float2 crp=max(pos-(1.0-crn*aspect),0.0)/aspect;float cd=sqrt(dot(crp,crp));
	pos=max(pos,1.0-crn+cd);
	float res=lerp(1.0,0.0,smoothstep(1.0-b,1.0,sqrt(max(pos.x,pos.y))));
	return pow(res,sborder);
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

float3 gc2(float3 c,float w3)
{
	float mc=max(max(c.r,c.g),c.b);
	float p=1.0/(1.0+(gamma_d-1.0)* lerp(0.375,1.0,w3));
	float mg=pow(mc, p );
	return c*mg/(mc+eps);
}

float3 noise(float3 v)
{
	if(addnoised<0.0)v.z=-addnoised;else v.z= mod(v.z,6001.0)/1753.0;
	v =frac(v)+frac(v*1e4)+frac(v*1e-4);
	v+=float3(0.12345,0.6789,0.314159);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	return v;
}

void bring_pixel(inout float3 c,inout float3 b,inout float3 g,float2 coord,float2 boord)
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
	float r1=texCD(NTSC_S13,coord+rc).r;
	float g1=texCD(NTSC_S13,coord+gc).g;
	float b1=texCD(NTSC_S13,coord+bc).b;
	float ds=decons;
	float3 d=float3(r1,g1,b1);
	c=clamp(lerp(c,d,ds),0.0,1.0);
	r1=texCD(NTSC_S12,boord+rc).r;
	g1=texCD(NTSC_S12,boord+gc).g;
	b1=texCD(NTSC_S12,boord+bc).b;
	d=float3(r1,g1,b1);
	b=g=lerp(b,d,min(ds,1.0));
	r1=texCD(NTSC_S10,boord+rc).r;
	g1=texCD(NTSC_S10,boord+gc).g;
	b1=texCD(NTSC_S10,boord+bc).b;
	d=float3(r1,g1,b1);
	g=lerp(g,d,min(ds,1.0));
}

float4 StockPassPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	return texCD(NTSC_S00,texcoord);
}

float4 Signal_1_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float pix_res= min(ntsc_scale,1.0);
	float phase= (ntsc_phase<1.5)?((OrgSize.x>300.0)? 2.0:3.0):((ntsc_phase>2.5)?3.0:2.0);
	if(ntsc_phase==4.0)phase=3.0;
	float res=ntsc_scale;
	float CHROMA_MOD_FREQ=(phase<2.5)?(4.0*pii/15.0):(pii/3.0);
	float ARTIFACT=cust_artifacting;
	float FRINGING=cust_fringing;
	float BRIGHTNESS=ntsc_brt;
	float SATURATION=ntsc_sat;
	float MERGE=0.0;
	if(ntsc_fields== 1.0&&phase==3.0) MERGE=1.0;else
	if(ntsc_fields== 2.0) MERGE=0.0;else
	if(ntsc_fields== 3.0) MERGE=1.0;
	float2 pix_no=texcoord*OrgSize.xy*pix_res* float2(4.0,1.0);
	float3 col0=texCD(NTSC_S01, texcoord).rgb;
	float3 yiq1=rgb2yiq(col0);
	yiq1.x=pow(yiq1.x,ntsc_gamma); float lum=yiq1.x;
	float2 dx=float2(OrgSize.z,0.0);
	float c1=get_luma(texCD(NTSC_S01,texcoord-dx).rgb);
	float c2=get_luma(texCD(NTSC_S01,texcoord+dx).rgb);
	if(ntsc_phase==4.0)
	{
	float miix=min(5.0*abs(c1-c2),1.0);
	c1=pow(c1,ntsc_gamma);
	c2=pow(c2,ntsc_gamma);
	yiq1.x=lerp(min(0.5*(yiq1.x+max(c1,c2)),max(yiq1.x,min(c1,c2))),yiq1.x,miix);
	}
	float3 yiq2=yiq1;
	float3 yiqs=yiq1;
	float3 yiqz=yiq1;
	float3 temp=yiq1;
	float mit=ntsc_taps;if(ntsc_charp1>0.25&&phase==2.0)mit=clamp(mit,8.0,min(ntsc_taps,14.0));
	mit=swoothstep(16.0,8.0,mit)*0.325;
	if(MERGE>0.5)
	{
	float chroma_phase2=(phase<2.5)?pii*(mod(pix_no.y,2.0)+mod(float(framecount)+1,2.)):0.6667*pii*(mod(pix_no.y,3.0)+mod(float(framecount)+1,2.));
	float mod_phase2=chroma_phase2+pix_no.x*CHROMA_MOD_FREQ;
	float i_mod2=cos( mod_phase2 );
	float q_mod2=sin( mod_phase2 );
	yiq2.yz*=float2(i_mod2,q_mod2);
	yiq2=mul(mix_m,yiq2);
	yiq2.yz*=float2(i_mod2,q_mod2);
	yiq2.yz =lerp(yiq2.yz,temp.yz,mit);
	if(res>1.025)
	{
	mod_phase2=chroma_phase2 +res *pix_no.x*CHROMA_MOD_FREQ;
	i_mod2=cos(mod_phase2);
	q_mod2=sin(mod_phase2);
	yiqs.yz*=float2(i_mod2,q_mod2);
	yiq2.x=dot(yiqs,mix_m[0]);
	}
	}
	float chroma_phase1=(phase<2.5)?pii*(mod(pix_no.y,2.0)+mod(float(framecount)  ,2.)):0.6667*pii*(mod(pix_no.y,3.0)+mod(float(framecount)  ,2.));
	float mod_phase1=chroma_phase1+pix_no.x*CHROMA_MOD_FREQ;
	float i_mod1=cos( mod_phase1 );
	float q_mod1=sin( mod_phase1 );
	yiq1.yz*=float2(i_mod1,q_mod1);
	yiq1=mul(mix_m,yiq1);
	yiq1.yz*=float2(i_mod1,q_mod1);
	yiq1.yz =lerp(yiq1.yz,temp.yz,mit);
	if(res>1.025)
	{
	mod_phase1=chroma_phase1 +res *pix_no.x*CHROMA_MOD_FREQ;
	i_mod1=cos(mod_phase1);
	q_mod1=sin(mod_phase1);
	yiqz.yz*=float2(i_mod1,q_mod1);
	yiq1.x=dot(yiqz,mix_m[0]);
	}
	if(ntsc_phase==4.0){yiq1.x=lum;yiq2.x=lum;}
	if(MERGE>0.5){if(ntsc_rainbow<0.5||phase>2.5)yiq1=0.5*(yiq1+yiq2); else yiq1.x=0.5*(yiq1.x+yiq2.x);}
	return float4(yiq1,lum);
}

float4 Signal_2_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float chroma_filter_2_phase[33]={
    0.001384762, 0.001678312, 0.002021715, 0.002420562, 0.002880460, 0.003406879, 0.004004985, 0.004679445, 0.005434218, 0.006272332, 0.007195654,
    0.008204665, 0.009298238, 0.010473450, 0.011725413, 0.013047155, 0.014429548, 0.015861306, 0.017329037, 0.018817382, 0.020309220, 0.021785952,
    0.023227857, 0.024614500, 0.025925203, 0.027139546, 0.028237893, 0.029201910, 0.030015081, 0.030663170, 0.031134640, 0.031420995, 0.031517031};
	float chroma_filter_3_phase[25]={
   -0.000118847,-0.000271306,-0.000502642,-0.000930833,-0.001451013,
   -0.002064744,-0.002700432,-0.003241276,-0.003524948,-0.003350284,
   -0.002491729,-0.000721149, 0.002164659, 0.006313635, 0.011789103,
    0.018545660, 0.026414396, 0.035100710, 0.044196567, 0.053207202,
    0.061590275, 0.068803602, 0.074356193, 0.077856564, 0.079052396};
	float luma_filter_2_phase[33]={
   -0.000174844,-0.000205844,-0.000149453,-0.000051693, 0.000000000,-0.000066171,-0.000245058,-0.000432928,-0.000472644,-0.000252236, 0.000198929,
    0.000687058, 0.000944112, 0.000803467, 0.000363199, 0.000013422, 0.000253402, 0.001339461, 0.002932972, 0.003983485, 0.003026683,-0.001102056,
   -0.008373026,-0.016897700,-0.022914480,-0.021642347,-0.028863273, 0.027271957, 0.054921920, 0.098342579, 0.139044281, 0.168055832, 0.178571429};
	float luma_filter_3_phase[25]={
   -0.000012020,-0.000022146,-0.000013155,-0.000012020,-0.000049979,
   -0.000113940,-0.000122150,-0.000005612, 0.000170516, 0.000237199,
    0.000169640, 0.000285688, 0.000984574, 0.002018683, 0.002002275,
   -0.005909882,-0.012049081,-0.018222860,-0.022606931, 0.002460860,
    0.035868225, 0.084016453, 0.135563500, 0.175261268, 0.220176552};
	float luma_filter_4_phase[25]={
   -0.000472644,-0.000252236, 0.000198929, 0.000687058, 0.000944112,
    0.000803467, 0.000363199, 0.000013422, 0.000253402, 0.001339461,
    0.002932972, 0.003983485, 0.003026683,-0.001102056,-0.008373026,
   -0.016897700,-0.022914480,-0.021642347,-0.028863273, 0.027271957,
    0.054921920, 0.098342579, 0.139044281, 0.168055832, 0.178571429};
	const int TAPS_2_phase=32;
	const int TAPS_3_phase=24;
	float res=ntsc_scale;
	float3 signal=0.0;
	float2 one=0.25*OrgSize.zz/res;
	float2 tex_c=texcoord+float2(0.5*OrgSize.z/4.0,0.0);
	float phase= ( ntsc_phase<1.5)?((OrgSize.x>300.0)?2.0:3.0):((ntsc_phase>2.5)?3.0:2.0);
	if(ntsc_phase==4.0){phase=3.0;luma_filter_3_phase=luma_filter_4_phase;}
	float3 wsum =0.0.xxx;
	float3 sums=wsum;
	float3 tmps=wsum;
	float offset=0.0;int i=0;
	float j =0.0;
	if(phase<2.5)
	{
	float loop=max(ntsc_taps,8.0);
	if(ntsc_charp1>0.25)loop=min(loop,14.0);
	float loob=loop+1.0;
	float taps=0.0;
	float ssub=loop-loop/ntsc_cscale1;
	float mit=1.0+0.0375*pow(swoothstep(16.0,8.0,loop),0.5);
	float2 dx=float2(one.x*mit,0.0);
	float2 xd=dx; int loopstart=int(TAPS_2_phase-loop);
	for(i=loopstart;i<32;i++)
	{
	offset=float(i-loopstart);
	j=offset+1.0;xd= (offset-loop)*dx;
	sums=fetch_offset1(xd);
	taps=max(j-ssub,0.0);
	tmps=float3(luma_filter_2_phase[i], taps.xx );
	wsum=wsum+tmps; signal+=sums*tmps;
	}
	taps=loob-ssub;
	tmps=float3(luma_filter_2_phase[TAPS_2_phase], taps.xx);
	wsum=wsum+wsum+tmps;
	signal+=texCD(NTSC_S02,tex_c).xyz*tmps;
	signal =signal/wsum;
	}else
	{
	float loop=min(ntsc_taps,TAPS_3_phase); one.y=one.y/ntsc_cscale2;
	float mit=1.0;
	if(ntsc_phase==4.0){loop=max(loop,8.0); mit=1.0+0.0375*pow(swoothstep(16.0,8.0,loop),0.5);}
	float3 dx=float3(one.x,one.y,0.0);
	float3 xd=dx; int loopstart=int(TAPS_3_phase-loop);
	dx.x*=mit;
	for(i=loopstart;i<24;i++)
	{
	offset=float(i-loopstart);
	j=offset+1.0;xd.xy=(offset-loop)*dx.xy;
	sums=fetch_offset2(xd);
	tmps=float3(luma_filter_3_phase[i], chroma_filter_3_phase[i].xx);
	wsum=wsum+tmps; signal+=sums*tmps;
	}
	tmps=float3(luma_filter_3_phase[TAPS_3_phase], chroma_filter_3_phase[TAPS_3_phase], chroma_filter_3_phase[TAPS_3_phase]);
	wsum=wsum+wsum+tmps;
	signal+=texCD(NTSC_S02,tex_c).xyz*tmps;
	signal =signal/wsum;
	}
	signal.x=clamp( signal.x,0.0,1.0);
	if(ntsc_ring>0.05)
	{
	float2 dx=float2(OrgSize.z/min(res,1.0),0.0);
	float a=texCD(NTSC_S02,tex_c-2.0*dx).a;
	float b=texCD(NTSC_S02,tex_c-    dx).a;
	float c=texCD(NTSC_S02,tex_c+2.0*dx).a;
	float d=texCD(NTSC_S02,tex_c+    dx).a;
	float e=texCD(NTSC_S02,tex_c       ).a;
	signal.x=lerp(signal.x,clamp(signal.x,min(min(min(a,b),min(c,d)),e),max(max(max(a,b),max(c,d)),e)),ntsc_ring);
	}
	float x=get_luma(texCD(NTSC_S01, tex_c).rgb);
	return float4(signal,x);
}

float4 Signal_3_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float2 dx=float2(0.25*OrgSize.z/4.0,0.0);
	float2 xx=float2(0.50*OrgSize.z,0.0);
	float2 tex_c=texcoord+float2(0.5*OrgSize.z/4.0,0.0);float2 tcoord=tex_c-2.0*dx;
	float2 tcoorb=(floor(OrgSize.xy*tex_c)+0.5)*OrgSize.zw;
	float lcoord=OrgSize.x*(tex_c.x+dx.x )-0.5;
	float fpx=frac(lcoord);
	lcoord =(floor(lcoord)+0.5)*OrgSize.z;
	float3 ll1=texCD(NTSC_S03,tcoord+ xx).xyz;
	float3 ll2=texCD(NTSC_S03,tcoord- xx).xyz;
	float dy=0.0;
	xx=float2(OrgSize.z,0.0);
	float phase= (ntsc_phase<1.5)?((OrgSize.x>300.0)? 2.0:3.0):((ntsc_phase>2.5)?3.0:2.0);
	if(ntsc_phase==4.0)phase=3.0;
	float ca=texCD(NTSC_S02,tcoorb-xx-xx).a;
	float c0=texCD(NTSC_S02,tcoorb-xx   ).a;
	float c1=texCD(NTSC_S02,tcoorb      ).a;
	float c2=texCD(NTSC_S02,tcoorb+xx   ).a;
	float cb=texCD(NTSC_S02,tcoorb+xx+xx).a;
	float th=(phase<2.5)?0.025:0.0075;
	float line0=    swoothstep(th,0.0,min(abs(c1-c0),abs(c2-c1)));
	float line1=max(swoothstep(th,0.0,min(abs(ca-c0),abs(c2-cb))), line0 );
	float line2=max(swoothstep(th,0.0,min(abs(ca-c2),abs(c0-cb))), line1 );
	if( ntsc_rainbow>0.5&&phase<2.5)
	{
	float ybool1=1.0;bool ybool2=(c0==c1&&c1==c2);
	if((ntsc_rainbow<1.5)&&bool(line0))ybool1=0.0;else
	if((ntsc_rainbow<2.5)&&bool(line2))ybool1=0.0;else
	if(ybool2)ybool1=0.0;
	float liine_no=floor( mod(OrgSize.y*tex_c.y,2.0));
	float frame_no=floor( mod(float(framecount),2.0));
	float ii=abs(liine_no-frame_no);
	dy=ii*OrgSize.w*ybool1;
	}
	float3 ref=texCD(NTSC_S03,tcoord).xyz;
	float2 org=ref.yz;
	ref.yz= texCD(NTSC_S03,tcoord+float2(0.0,dy)).yz;
	float lum1=min(texCD(NTSC_S02,tex_c-dx).a, texCD(NTSC_S02,tex_c+dx).a);
	float lum2=ref.x ;
	float3 ll3=abs(ll1-ll2);
	float di=max(max(ll3.x,ll3.y),max(ll3.z,abs(ll1.x*ll1.x-ll2.x*ll2.x)));
	float df=pow(di,0.125);
	float lc=swoothstep(0.20,0.10,abs(lum2-lum1))*df;
	float tmp1=swoothstep(0.05-0.03*lc,0.425-0.375*lc,di);
	float tmp2=pow((tmp1+0.1)/1.1,0.25);
	float sweight=lerp(tmp1,tmp2,line0);
	float zweight=lerp(tmp1,tmp2,line2);
	float3 signal=ref;
	float ntzc_shrp= abs(ntsc_shrp);
	if(ntzc_shrp>0.25)
	{
	float mixer=sweight;
	if(ntsc_shrp>0.25)mixer=zweight; mixer*=0.1*ntzc_shrp;
	float lumix=lerp(lum2,lum1,mixer);
	float lm1=lerp(lum2*lum2 ,lum1*lum1 ,mixer);lm1=sqrt(lm1);
	float lm2=lerp(sqrt(lum2),sqrt(lum1),mixer);lm2=lm2* lm2 ;
	float k1=abs(lumix-lm1)+0.00001;
	float k2=abs(lumix-lm2)+0.00001;
	signal.x=min((k2*lm1+k1*lm2)/(k1+k2),1.0);
	signal.x=min(signal.x,max(ntsc_shpe*signal.x,lum2));
	}
	if((ntsc_charp1+ntsc_charp2)>0.25)
	{
	float mixer=sweight;
	if(ntsc_shrp>0.25)mixer=zweight;
	mixer =lerp(swoothstep(0.075,0.125,max(ll3.y,ll3.z)),swoothstep(0.015,0.0275,di),line2)*mixer;
	mixer*=0.1*((phase<2.5)? ntsc_charp1:ntsc_charp2);
	tcoord=float2(lcoord,tcoord.y);
	float3 origin=rgb2yiq(lerp(texCD(NTSC_S01,tcoord).rgb,texCD(NTSC_S01,tcoord+xx).rgb,clamp(1.5*fpx-0.25,0.0,1.0)));
	signal.yz=lerp(signal.yz,origin.yz,mixer);
	}
	if(ntsc_rainbow==2.0&&phase<2.5){signal.yz=lerp(signal.yz,org,zweight);}
	signal.x=pow(signal.x,1.0/ntsc_gamma);
	signal=clamp(yiq2rgb(signal),0.0,1.0);
	return float4(signal,1.0);
}

float4 SharpnessPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float2 g01=float2(-0.5*OrgSize.z,0.0);
	float2 g21=float2( 0.5*OrgSize.z,0.0);
	float3 c01=texCD(NTSC_S04,texcoord+g01).rgb;
	float3 c21=texCD(NTSC_S04,texcoord+g21).rgb;
	float3 c11=texCD(NTSC_S04,texcoord    ).rgb;
	float3 b11=0.5*(c01+c21);
	float contrazt=max(max(c11.r,c11.g),c11.b);
	contrazt=lerp(2.0*CCONTR,CCONTR,contrazt);
	float3 nim=min(min(c01,c21),c11);float3 mn1=min(nim,c11*(1.0-contrazt));
	float3 xam=max(max(c01,c21),c11);float3 mx1=max(xam,c11*(1.0+contrazt));
	float3 di0=pow(mx1-mn1+0.00001,0.75);
	float3 sharpen=lerp(CSHARPEN*CDETAILS,CSHARPEN,di0);
	float3 res=clamp(lerp(c11,b11,-sharpen),mn1,mx1);
	if(DEBLUR>1.125)
	{
	float2 toxcoord=(floor(OrgSize.xy*texcoord)+0.5)*OrgSize.zw;
	float l01=get_luma(texCD(NTSC_S01,texcoord+2.0*g01).rgb);
	float l21=get_luma(texCD(NTSC_S01,texcoord+2.0*g21).rgb);
	float l11=get_luma(texCD(NTSC_S01,toxcoord        ).rgb);
	float d11=min(min(l01,l21),l11);
	l11=max(max(l01,l21),l11);
	float lmn=min(min(get_luma(c01),get_luma(c21)),get_luma(c11));float ln1=min(lerp(d11,lmn,lmn),lmn);
	float lmx=max(max(get_luma(c01),get_luma(c21)),get_luma(c11));float lx1=max(lerp(lmx,l11,lmx),lmx);
	float r11=get_luma(res);
	float di1=max((r11-ln1),0.0)+0.00001;di1=pow(di1,DEBLUR);
	float di2=max((lx1-r11),0.0)+0.00001;di2=pow(di2,DEBLUR);
	float ratio=di1/(di1+di2);
	float zharpen=lerp(ln1,lx1,ratio);
	zharpen=min(zharpen,max(DREDGE*zharpen,r11));
	res=rgb2yiq(res);
	d11=res.x;
	res.x=zharpen;
	res.x=clamp((1.0+ DSHARP)* res.x-DSHARP*d11,ln1*(1.0-contrazt),lx1*(1.0+contrazt));
	res=max(yiq2rgb(res),0.0);
	}
	return float4(res,1.0);
}

float4 LuminancePS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float m=max(log2(LumSize.x),log2(LumSize.y));
	m=floor(max(m,1.0))-1.0;
	float2 dx=float2(1.0/LumSize.x,0.0);
	float2 dy=float2(0.0,1.0/LumSize.y);
	float2 x2=2.0*dx;
	float2 y2=2.0*dy;
	float ltotal=0.0;
	ltotal+=length(tex2Dlod(NTSC_S05,float4(float2(0.3,0.3),m,0)).rgb);
	ltotal+=length(tex2Dlod(NTSC_S05,float4(float2(0.3,0.7),m,0)).rgb);
	ltotal+=length(tex2Dlod(NTSC_S05,float4(float2(0.7,0.3),m,0)).rgb);
	ltotal+=length(tex2Dlod(NTSC_S05,float4(float2(0.7,0.7),m,0)).rgb);
	ltotal*=0.25;
	ltotal=pow(0.577350269*ltotal,0.7);
	float lhistory=texCD(NTSC_S06,float2(0.5,0.5)).a;
	ltotal=lerp(ltotal,lhistory,lsmooth);
	float3 l1=texCD(NTSC_S05,fuxcoord.xy   ).rgb;
	float3 r1=texCD(NTSC_S05,fuxcoord.xy+dx).rgb;
	float3 l2=texCD(NTSC_S05,fuxcoord.xy-dx).rgb;
	float3 r2=texCD(NTSC_S05,fuxcoord.xy+x2).rgb;
	float c1=dist(l2,l1);
	float c2=dist(l1,r1);
	float c3=dist(r2,r1);
	return float4(c1,c2,c3,ltotal);
}

float4 LinearizePS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float3 c1=texCD(NTSC_S05,fuxcoord).rgb;
	float3 c2=texCD(NTSC_S05,fuxcoord+float2(0.0,OrgSize.w)).rgb;
	if((downsample_levelx+downsample_levely)>0.025)
	{
	c1=fetch_pixel(fuxcoord);
	c2=fetch_pixel(fuxcoord+float2(0.0,OrgSize.w));
	}
	float3 c=c1;
	float intera=1.0;
	float gamma_in=gamma_i;
	float m1=max(max(c1.r,c1.g),c1.b);
	float m2=max(max(c2.r,c2.g),c2.b);
	float3 df=abs(c1-c2);
	float d=max(max(df.r,df.g),df.b);
	if(interm==2.0) d=lerp(0.1*d,10.0*d,step(m1/(m2+0.0001),m2/(m1+0.0001)));
	float r=m1;
	float yres_div=1.0;if(intres>1.25)yres_div=intres;
	bool hscans=(hiscan>0.5);
	if(interr<=OrgSize.y/yres_div&&interm>0.5&&intres!=1.0&&intres!=0.5||hscans)
	{
	intera=0.25;
	float liine_no=floor( mod(OrgSize.y*fuxcoord.y,2.0));
	float frame_no=floor( mod(float(framecount),2.0));
	float ii=abs(liine_no-frame_no);
	if(interm< 3.5)
	{
	c2=plant(lerp(c2,c2*c2,iscans),max(max(c2.r,c2.g),c2.b));
	r=max(m1*ii,(1.0-iscanb)*min(m1,m2));
	c=plant(lerp(lerp(c1,c2,min(lerp(m1,1.0-m2,min(m1,1.0-m1))/(d+0.00001),1.0)),c1,ii),r);
	if(interm==3.0) c=(1.0-0.5*iscanb)*lerp(c2,c1,ii);
	}
	if(interm==4.0){c=plant(lerp(c,c*c,0.5*iscans),max(max(c.r,c.g),c.b))*(1.0-0.5*iscanb);
	}
	if(interm==5.0){c=lerp(c2,c1,0.5);c=plant(lerp(c,c*c,0.5*iscans),max(max(c.r,c.g),c.b))*(1.0-0.5*iscanb);
	}
	if(hscans)c=c1;
	}
	c=pow(c,gamma_in);
	if(fuxcoord.x>0.5)gamma_in=intera;else gamma_in=1.0/gamma_in;
	return float4(c,gamma_in);
}

float4 HGaussianPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float FINE_GAUSS= (FINE_GAUSS>0.5)? FINE_GAUSS: lerp(0.75,0.50,-FINE_GAUSS);
	float4 AdvSize=float4(OrgSize.x,OrgSize.y,OrgSize.z,OrgSize.w)*float4(FINE_GAUSS,FINE_GAUSS,1.0/FINE_GAUSS,1.0/FINE_GAUSS);
	float f=frac(AdvSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float3 color=0.0;
	float2 dx=float2(AdvSize.z ,0.0);
	float3 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEH;
	do
	{
	pixel=texCD(NTSC_S07,tex+n*dx).rgb;
	if(m_glow>0.5)
	{
	pixel=max(pixel-m_glow_cutoff,0.0);
	pixel=plant(pixel,max(max(max(pixel.r,pixel.g),pixel.b)-m_glow_cutoff,0.0));
	}
	w=gauss_h(n+f);
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEH);
	color=color/wsum;
	return float4(color,1.0);
}

float4 VGaussianPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float FINE_GAUSS= (FINE_GAUSS>0.5)? FINE_GAUSS: lerp(0.75,0.50,-FINE_GAUSS);
	float4 AdvSize=float4(SrcSize.x,OrgSize.y,SrcSize.z,OrgSize.w)*float4(FINE_GAUSS,FINE_GAUSS,1.0/FINE_GAUSS,1.0/FINE_GAUSS);
	float f=frac(AdvSize.y*texcoord.y);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float3 color=0.0;
	float2 dy=float2(0.0,AdvSize.w );
	float3 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEV;
	do
	{
	pixel=texCD(NTSC_S09,tex+n*dy).rgb;
	w=gauss_v(n+f);
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEV);
	color=color/wsum;
	return float4(color,1.0);
}

float4 BloomHorzPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float FINE_BLOOM= (FINE_BLOOM>0.5)? FINE_BLOOM: lerp(0.75,0.50,-FINE_BLOOM);
	float4 AdvSize=float4(OrgSize.x,OrgSize.y,OrgSize.z,OrgSize.w)*float4(FINE_BLOOM,FINE_BLOOM,1.0/FINE_BLOOM,1.0/FINE_BLOOM);
	float f=frac(AdvSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float4 color=0.0;
	float2 dx=float2(AdvSize.z ,0.0);
	float4 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEX;
	do
	{
	pixel=texCD(NTSC_S07,tex+n*dx);
	w=bloom_h(n+f);
	pixel.a =max(max(pixel.r,pixel.g),pixel.b);
	pixel.a*=pixel.a*pixel.a;
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEX);
	color=color/wsum;
	return float4(color.rgb,pow(color.a,0.333333));
}

float4 BloomVertPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float FINE_BLOOM= (FINE_BLOOM>0.5)? FINE_BLOOM: lerp(0.75,0.50,-FINE_BLOOM);
	float4 AdvSize=float4(SrcSize.x,OrgSize.y,SrcSize.z,OrgSize.w)*float4(FINE_BLOOM,FINE_BLOOM,1.0/FINE_BLOOM,1.0/FINE_BLOOM);
	float f=frac(AdvSize.y*texcoord.y);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float4 color=0.0;
	float2 dy=float2(0.0,AdvSize.w );
	float4 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEY;
	do
	{
	pixel=texCD(NTSC_S11,tex+n*dy);
	w=bloom_v(n+f);
	pixel.a*=pixel.a*pixel.a;
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEY);
	color=color/wsum;
	return float4(color.rgb,pow(color.a,0.175000));
}

float4 NTSC_TV1_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float f=frac(LumSize.x*fuxcoord.x);
	f=0.5-f;
	float2 tex=floor(LumSize.xy*fuxcoord)*LumSize.zw+0.5*LumSize.zw;
	float3 color=0.0.xxx;
	float solor=0.0;
	float2 dx=float2(LumSize.z ,0.0);
	float3 pixel;
	float w=0.0;
	float swum=0.0;
	float wsum=0.0;
	float xs=2.0*0.50;
	float hsharpness=HSHARPNESS*xs*internal_res;
	float3 cmax=0.0.xxx;
	float3 cmin=1.0.xxx;
	float sharp=crthd_h(hsharpness,xs) *S_SHARP;
	float maxsharp=MAXS;
	float FPR=hsharpness;
	float FPRi=1.0/hsharpness;
	float fpx=0.0;
	float sp=0.0;
	float sw=0.0;
	float ts=0.025;
	float3 luma=float3(0.2126,0.7152,0.0722);
	float LOOPSIZE=ceil(2.0*FPR);
	float n=-LOOPSIZE;
	do
	{
	pixel=texCD(NTSC_S07,tex+n*dx).rgb;
	w=crthd_h(n+f,xs)-sharp;
	fpx=(abs(n+f)-FPR)*FPRi;
	if(w<0.0)w=max(w,lerp(-maxsharp,0.0,pow(clamp(fpx,0.0,1.0),SHARP))); else
	{
	cmax=max(cmax,pixel);cmin=min(cmin,pixel);sw=w*(dot(pixel,luma)+ts);
	sp=max(max(pixel.r,pixel.g),pixel.b);
	solor=solor+sw*sp;
	swum=swum+sw;
	}
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=LOOPSIZE);
	color=color/wsum;
	solor=solor/swum;
	color=clamp(lerp( clamp (color,cmin,cmax),color,SSRNG),0.0,1.0);
	solor=clamp(lerp(max(max(color.r,color.g),color.b),solor,spike),0.0,1.0);
	return float4(color,solor);
}

float4 NTSC_TV2_PS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float gamma_in=1.0/texCD(NTSC_S07,float2(0.25,0.25)).a;
	float lum=texCD(NTSC_S06,float2(0.5,0.5)).a;
	float intera=texCD(NTSC_S07,float2(0.75,0.25)).a;
	bool hscans=(hiscan>0.5);
	bool interb=(((intera<0.35)||(no_scanlines>0.025))&&!hscans);
	float4 AdvSize= LumSize;
	float SourceY=AdvSize.y;
	float sy=1.0;
	if( intres==1.0)sy=max(round(SourceY/224.0),1.0);
	if( intres>0.25&&intres!=1.0)sy=intres;
	AdvSize*=float4(1.0,1.0/sy,1.0,sy);
	float2 lexcoord=fuxcoord.xy;
	if(IOS> 0.0&& !interb)
	{
	float2 ofactor= OptSize.xy/OrgSize.xy;
	float2 ifactor=(IOS<2.5)? floor(ofactor):ceil(ofactor);
	float2 diff=ofactor/ifactor;
	float scan=diff.y;
	lexcoord=overscan(lexcoord,scan,scan);
	if(IOS==1.0||IOS==3.0) lexcoord=float2(fuxcoord.x,lexcoord.y);
	}
	float factor=1.0+(1.0-0.5*OS)*blm_2/100.0-lum*blm_2/100.0;
	lexcoord=overscan(lexcoord,factor,factor);
	lexcoord=overscan(lexcoord,(OrgSize.x-overscanx)/OrgSize.x,(OrgSize.y-overscany)/OrgSize.y);
	float2 pos = warp(lexcoord);
	float2 coffset=0.5;
	float2 ps=AdvSize.zw;
	float2 OGL2Pos=pos*AdvSize.xy-coffset;
	float2 fp=frac(OGL2Pos);
	float2 dx=float2(ps.x,0.0);
	float2 dy=float2(0.0,ps.y);
	float f=fp.y;
	float2 pC4=floor(OGL2Pos)*ps+0.5*ps;
	pC4.x=pos.x;
	if( intres==0.5<1.5)pC4.y=floor(pC4.y*OrgSize.y)*OrgSize.w+0.5*OrgSize.w;
	if( interb&&no_scanlines<0.025|| hscans) pC4.y=pos.y;else
	if( interb) pC4.y=pC4.y+smoothstep(0.40-0.5*no_scanlines,0.60+0.5*no_scanlines,f)*AdvSize.w;
	float3 color1=texCD(NTSC_S08,pC4).rgb;
	float3 solor1=texCD(NTSC_S08,pC4).aaa;
	if(!interb)color1=pow(color1,scangamma/gamma_in);
	pC4+=dy;
	if( intres==0.5<1.5)pC4.y=floor((pos.y+0.33*dy.y)*OrgSize.y)*OrgSize.w+0.5*OrgSize.w;
	float3 color2=texCD(NTSC_S08,pC4).rgb;
	float3 solor2=texCD(NTSC_S08,pC4).aaa;
	if(!interb)color2=pow(color2,scangamma/gamma_in);
	float3 ctmp=color1;float w3=1.0;float3 color=color1;
	float3 one=1.0;
	if( hscans){color2=color1;solor2=solor1;}
	if(!interb|| hscans)
	{
	float shape1=lerp(scanline1,scanline2,    f);
	float shape2=lerp(scanline1,scanline2,1.0-f);
	float wt1=st0(    f);
	float wt2=st0(1.0-f);
	float3 color0=color1*wt1+color2*wt2;
	float3 solor0=solor1*wt1+solor2*wt2;
	ctmp = color0/(wt1+wt2);
	float3 stmp=solor0/(wt1+wt2);
	if(abs(rolling_scan)>0.005){color1=ctmp;color2=ctmp;solor1=stmp;solor2=stmp;}
	float3 w1,w2;
	float3 cref1=lerp(stmp,solor1,beam_size);float creff1=pow(max(max(cref1.r,cref1.g),cref1.b),scan_falloff);
	float3 cref2=lerp(stmp,solor2,beam_size);float creff2=pow(max(max(cref2.r,cref2.g),cref2.b),scan_falloff);
	if(tds>0.5){shape1=lerp(scanline2,shape1,creff1);shape2=lerp(scanline2,shape2,creff2);}
	float scanpix=OrgSize.y/OptSize.y;
	float f1=frac(f-rolling_scan*float(framecount)*scanpix);
	float f2=1.0-f1;
	float m1=max(max(color1.r,color1.g),color1.b)+eps;
	float m2=max(max(color2.r,color2.g),color2.b)+eps;
	cref1=color1/m1;
	cref2=color2/m2;
	if(gsl< 0.5)
	{w1=sw0(f1,creff1,shape1,cref1);w2=sw0(f2,creff2,shape2,cref2);}else
	if(gsl==1.0)
	{w1=sw1(f1,creff1,shape1,cref1);w2=sw1(f2,creff2,shape2,cref2);}else
	{w1=sw2(f1,creff1,shape1,cref1);w2=sw2(f2,creff2,shape2,cref2);}
	float3 w3=w1+w2;
	float wf1=max(max(w3.r,w3.g),w3.b);
	if(wf1>1.0){wf1=1.0/wf1;w1*=wf1,w2*=wf1;}
	if(abs(clp)>0.005)
	{
	sy=m1; one=(clp>0.0)?w1:1.0.xxx;
	float sat=1.0001-min(min(cref1.r,cref1.g),cref1.b);
	color1=lerp(color1,plant(pow(color1,0.70.xxx-0.325*sat),sy),pow(sat,0.3333)*one*abs(clp));
	sy=m2; one=(clp>0.0)?w2:1.0.xxx;
	sat=1.0001-min(min(cref2.r,cref2.g),cref2.b);
	color2=lerp(color2,plant(pow(color2,0.70.xxx-0.325*sat),sy),pow(sat,0.3333)*one*abs(clp));
	}
	color=gc1(color1)*w1+gc1(color2)*w2;
	color=min(color,1.0);
	}
	if( interb)
	{
	color=gc1(color1);
	}
	float colmx=max( max(ctmp.r,ctmp.g),ctmp.b);
	if(!interb)color=pow(color,gamma_in/scangamma);
	return float4(color,colmx);
}

float4 ChromaticPS(float4 position:SV_Position,float2 texcoord:TEXCOORD):SV_Target
{
	float gamma_in=1.0/texCD(NTSC_S07,float2(0.25,0.25)).a;
	float lum=texCD(NTSC_S06,float2(0.5,0.5)).a;
	float intera=texCD(NTSC_S07,float2(0.75,0.25)).a;
	bool interb=((intera<0.35||no_scanlines>0.025)&&(hiscan<0.5));
	float2 lexcoord=fuxcoord.xy;
	if(IOS> 0.0&& !interb)
	{
	float2 ofactor= OptSize.xy/OrgSize.xy;
	float2 ifactor=(IOS<2.5)? floor(ofactor):ceil(ofactor);
	float2 diff=ofactor/ifactor;
	float scan=diff.y;
	lexcoord=overscan(lexcoord,scan,scan);
	if(IOS==1.0||IOS==3.0) lexcoord=float2(fuxcoord.x,lexcoord.y);
	}
	float factor=1.0+(1.0-0.5*OS)*blm_2/100.0-lum*blm_2/100.0;
	lexcoord=overscan(lexcoord,factor,factor);
	lexcoord=overscan(lexcoord,(OrgSize.x-overscanx)/OrgSize.x,(OrgSize.y-overscany)/OrgSize.y);
	float2 pos0= warp(fuxcoord);
	float2 pos1= fuxcoord;
	float2 pos = warp(lexcoord);
	float3 color=texCD(NTSC_S13,pos1).rgb;
	float3 Bloom=texCD(NTSC_S12,pos ).rgb;
	float3 Glow =texCD(NTSC_S10,pos ).rgb;
	if((abs(deconrx)+abs(deconry)+abs(decongx)+abs(decongy)+abs(deconbx)+abs(deconby))>0.2) bring_pixel(color,Bloom,Glow,pos1,pos);
	float cm=igc(max(max(color.r,color.g),color.b));
	float mx1=texCD(NTSC_S13,pos1   ).a;
	float colmx=max(mx1,cm);
	float w3=min((max((cm-0.0005)*1.0005,0.0)+0.0001)/(colmx+0.0005),1.0);if(interb)w3=1.0;
	float2 dx=float2(0.001,0.0);
	float mx0=texCD(NTSC_S13,pos1-dx).a;
	float mx2=texCD(NTSC_S13,pos1+dx).a;
	float mxg=max(max(mx0,mx1),max(mx2,cm));
	float mx=pow(mxg,1.40/gamma_in);
	float cx=pow(colmx,1.40/gamma_in);
	dx=float2(OrgSize.z,0.0)*0.25;
	mx0=texCD(NTSC_S13,pos1-dx).a;
	mx2=texCD(NTSC_S13,pos1+dx).a;
	float mb=(1.0-min(abs(mx0-mx2)/(0.5+mx1),1.0));
	float3 orig1=color;
	float3 one=1.0;
	float3 cmask=one;
	float3 dmask=one;
	float3 emask=one;
	float mwidths[15]={0.0,2.0,3.0,3.0,6.0,6.0,2.4,3.5,2.4,3.25,3.5,4.5,4.25,7.5,6.25};
	float mwidth=mwidths[int(shadow_msk)];
	float mask_compensate=frac(mwidth);
	if(shadow_msk> 0.5)
	{
	float2 maskcoord= fracoord.xy;
	float2 scoord=maskcoord;
	mwidth=floor(mwidth)*masksize;
	float swidth=mwidth;
	bool zoomed=(abs(mask_zoom)>0.75);
	float mscale=1.0;
	float2 maskcoord0=maskcoord;
	maskcoord.y=floor(maskcoord.y/masksize);
	float mwidth0=max(mwidth+mask_zoom,2.0);
	if( mshift> 0.25)
	{
	float stagg_lvl=1.0; if(frac(mshift)>0.25)stagg_lvl=2.0;
	float next_line=float(floor(mod(maskcoord.y,2.0*stagg_lvl))<stagg_lvl);
	maskcoord0.x=maskcoord0.x+next_line*0.5*mwidth0;
	}
	maskcoord=maskcoord0/masksize;
	if(!zoomed)cmask*=crt_mask(floor(maskcoord),mx,mb);else
	{
	mscale=mwidth0/mwidth;
	float clerp= frac(maskcoord.x/mscale); if( zoom_mask>0.025 )clerp=clamp((1.0+zoom_mask)*clerp-0.5*zoom_mask,0.0,1.0);
	float coord=floor(maskcoord.x/mscale); if(shadow_msk==13.0&&mask_zoom==-2.0)coord=ceil(maskcoord.x/mscale);
	cmask*=lerp(crt_mask(float2(coord,maskcoord.y),mx,mb),crt_mask(float2(coord+1.0,maskcoord.y),mx,mb),clerp);
	}
	if(slotwidth>0.5)swidth=slotwidth;float smask=1.0;
	float sm_offset=0.0;bool bsm_offset=(shadow_msk==1.0||shadow_msk==3.0||shadow_msk==6.0||shadow_msk==7.0||shadow_msk==9.0||shadow_msk==12.0);
	if( zoomed)
	{
	if(mask_layout<0.5&&bsm_offset)sm_offset=1.0;else
	if(bsm_offset)sm_offset=-1.0;
	}
	swidth=round(swidth*mscale);
	smask =slt_mask(scoord+float2(sm_offset,0.0),mx,swidth);
	smask =clamp(smask+lerp(smask_mit,0.0,w3*pow(colmx,0.3)),0.0,1.0);
	emask =cmask;
	cmask*=smask;
	dmask =cmask;
	if(abs(mask_bloom)>0.025)
	{
	float maxbl=max( max(max(Bloom.r,Bloom.g),Bloom.b),mxg);
	maxbl=maxbl*max(lerp(1.0,2-colmx,bloom_dist),0.0);
	if(mask_bloom>0.025) cmask= max(min(cmask +maxbl*mask_bloom,1),cmask); else
	cmask=max(lerp(cmask,cmask*(1.0-0.5*maxbl)+plant(pow( Bloom,0.35.xxx),maxbl),-mask_bloom),cmask);
	}
	color=pow(color,mask_gamma/gamma_in);
	color=color*cmask;
	color=min(color,1.0);
	color=pow(color,gamma_in/mask_gamma);
	cmask=min(cmask,1.0);
	dmask=min(dmask,1.0);
	float mm=max(-2.75*cx*(cx-1.0)-lerp(0.075,0.165,cx),0.0);color=max(color,orig1*maskmid*mm);
	}
	float dark_compensate=lerp(max(clamp(lerp(mcut,maskstr,mx),0.0,1.0)-1.0+ mask_compensate,0.0)+1.0,1.0,mx); if(shadow_msk< 0.5) dark_compensate=1.0;
	float bb=lerp(brightboost1,brightboost2,mx)* dark_compensate; color*=bb;
	float3 Ref=texCD(NTSC_S07,pos).rgb;
	float maxb=texCD(NTSC_S12,pos).a;
	float3 bcmask=lerp(one,dmask,b_mask);
	float3 hcmask=lerp(one,dmask,h_mask);
	float3 Bloomy=Bloom;
	if(abs(blm_1)>0.025)
	{
	if(blm_1<-0.01)Bloomy=plant(Bloom,maxb);
	Bloomy= min(Bloomy*(orig1+color),max(0.5*(colmx+orig1-color),0.001*Bloomy));
	Bloomy=0.5*(Bloomy+lerp(Bloomy,lerp(colmx*orig1,Bloomy,0.5),1.0-color));
	Bloomy= bcmask*Bloomy*max(lerp(1.0,2.0-colmx,bloom_dist),0);
	color=pow(pow(color,mask_gamma/gamma_in)+abs(blm_1)*pow( Bloomy,mask_gamma/gamma_in),gamma_in/mask_gamma);
	}
	if(halation> 0.01)
	{
	Bloom= 0.5*(Bloom+Bloom*Bloom);float mbl=max(max(Bloom.r,Bloom.g),Bloom.b);float mxh=0.5*(colmx+colmx*colmx);
	mbl=lerp(lerp(mxh,lerp( mxh,mbl,mbl),colmx),mbl,mb);
	Bloom=plant(Bloom,lerp(sqrt(mbl*mxh),max((mbl-0.15*(1.0-colmx)),0.4*mxh),pow(colmx,0.25)))*lerp(0.425,1.0,colmx);
	Bloom=(3.0-colmx-color)*plant(0.325+orig1/w3,0.5*(1.0+w3))*hcmask*Bloom;
	color=pow(pow(color,mask_gamma/gamma_in)+ halation *pow( Bloom ,mask_gamma/gamma_in),gamma_in/mask_gamma);
	}else
	if(halation<-0.01)
	{
	float mbl=max(max(Bloom.r,Bloom.g),Bloom.b);
	Bloom=plant(Bloom+Ref+orig1+Bloom*Bloom*Bloom,min(mbl*mbl,0.75));
	color=color+2.0*lerp(1.0,w3,0.5*colmx)*hcmask*Bloom*(-halation);
	}
	color=min(color,1.0);
	color=gc2(color,w3 );
	if(smoothmask>0.125){float w4=pow(w3,0.425+0.3*smoothmask);w4=max(w4-0.175*colmx*smoothmask,0.2);color=lerp(min(color/w4,plant(orig1,1.0+0.175*colmx*smoothmask))*w4,color,w4);}
	if(m_glow<0.5)Glow=lerp(Glow,0.25*color,colmx);else
	{
	float3 orig2=plant(orig1+0.001*Ref,1.0); maxb=max(max(Glow.r,Glow.g),Glow.b);
	Bloom=plant(Glow,1.0);Ref=abs(orig2-Bloom);
	mx0=max(max(orig2.r,orig2.g),orig2.b)-min(min(orig2.r,orig2.g),orig2.b);
	mx2=max(max(Bloom.r,Bloom.g),Bloom.b)-min(min(Bloom.r,Bloom.g),Bloom.b);
	Bloom=lerp(maxb*min(Bloom,orig2),lerp(lerp(Glow,max(max(Ref.r,Ref.g),Ref.b)*Glow,max(mx,mx0)),lerp(color,Glow,mx2),max(mx0,mx2)*Ref),min(sqrt((1.10-mx0)*(0.10+mx2)),1.0));
	if(m_glow>1.5)Glow=lerp(0.5*Glow*Glow,Bloom,Bloom);
	Glow=lerp(m_glow_low*Glow,m_glow_high*Bloom,pow(colmx,m_glow_dist/gamma_in));
	}
	if(m_glow<0.5)
	{
	if(glow >=0.0)color=color+0.5*Glow*glow;else color=color+abs(glow)*min(emask*emask,1.0)*Glow;}else
	{
	float3 fmask=clamp(lerp(one,dmask,m_glow_mask),0.0,1.0);
	color=color+abs(glow)*fmask*Glow;
	}
	float vig=vignette(pos);
	color=min(color,1.0);
	if(edgemask>0.05)
	{
	mx0=texCD(NTSC_S13,pos1-dx).a;mx0=texCD(NTSC_S13,pos1-dx*(1.0-0.75*sqrt(mx0))).a;
	mx2=texCD(NTSC_S13,pos1+dx).a;mx2=texCD(NTSC_S13,pos1+dx*(1.0-0.75*sqrt(mx2))).a;
	float mx3=texCD(NTSC_S13,pos1-4.0*dx).a;
	float mx4=texCD(NTSC_S13,pos1+4.0*dx).a;
	mx4=max(pow(abs(mx3-mx4),0.55-0.40*cx),min(max(mx3,mx4)/min(0.1+cx,1.0),1.0));
	mb=(1.0-abs(pow(mx0,1.0-0.65*mx2)-pow(mx2,1.0-0.65*mx0)));
	mb=mx4*edgemask*(1.0001-mb*mb);float3 temp=lerp(color,orig1,mb);
	color=max(temp+lerp(3.5*mb*lerp(1.625*temp,temp,cx),0.0.xxx,pow(color,0.75.xxx -0.5*colmx)),color);
	}
	color=color* lerp(1.0,lerp(0.5*(1.0+w3),w3,mx),pr_scan);
	color=min(color,max(orig1,color)*lerp(one,dmask,mclip));
	color=pow(color,1.0/gamma_o);
	float q=0.6*sqrt(max(max(color.r,color.g),color.b))+0.4;
	if(abs(addnoised)>0.01)
	{
	float3 noise0=noise(float3(floor(OptSize.xy*fuxcoord/noiseresd),float(framecount)));
	if(noisetype<0.5)color=lerp(color,noise0,0.25*abs(addnoised)*q);else
	color=min(color* lerp(1.0,1.5*noise0.x,0.5*abs(addnoised)),1.0);
	}
	colmx=max(max(orig1.r,orig1.g),orig1.b);
	color=color+bmask*lerp(emask,0.125*(1.0-colmx)*color,min(20.0*colmx,1.0));
	return float4(color*vig*humbars(lerp(pos.y,pos.x,bardir))*post_br*corner(pos0),1.0);
}

technique CRT_Guest_NTSC
{
	pass StockPass
	{
	VertexShader=PostProcessVS;
	PixelShader=StockPassPS;
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