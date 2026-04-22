# UV Light Reveal – HDRP Decal Shader (Unity)
Reveals a texture only where a spotlight hits — works on any surface without modifying existing materials.
[![UV Light Demo](assets/uv-light-demo.gif)](https://youtu.be/0uOcl-USs-g)


🎬 Watch on YouTube: youtube.com/...

# Requirements

Unity HDRP
Any Unity version supporting Decal Projector


# Setup
## 1. HLSL File
Unity does not support creating HLSL files directly. Open your project folder in File Explorer, create a new text file and rename it to UVReveal.hlsl (make sure file extensions are visible in Explorer). Paste the HLSL code inside.
## 2. Shader Graph
Create an HDRP Decal Shader Graph, name it UVReveal. Inside the Shader Graph:

Add a Custom Function node → set Type to File, set Name to the function name without the _float suffix (e.g. UVReveal), and assign your UVReveal.hlsl to the Source field
Add a Position (Absolute World) node → connect to the Custom Function's WorldPos input
Sample your texture, multiply RGB and Alpha with the mask output → connect to Albedo and Emission

## 3. Material
Create a material from the UVReveal shader. Assign your texture and adjust the relevant fields on the material.

Make sure your texture has a proper alpha channel. Textures processed with a background remover tool work well.

## 4. Decal Projector
Add a Decal Projector to your scene and assign your material to its Material slot. Repeat this for each surface you want to reveal — one Decal Projector per texture placement.
## 5. UVLightController Script
Add the UVLightController script to your spotlight object in the scene. The script automatically reads the light's position, direction and range — no additional assignment needed.

The script uses SetGlobalVector / SetGlobalFloat, meaning all materials using these shader variables in the scene are updated automatically with a single light source.


# Notes

OnValidate was used during development for testing in the editor. Once you've set everything up, replace it with Update to run during gameplay (runtime).


# How does it work?
Built with AI assistance — paste the HLSL code into any AI (ChatGPT, Claude, etc.) and ask how it works or how to modify it.

# Credits & Resources

Textures used in the demo: 
<a href="https://www.freepik.com/free-vector/scary-blood-human-hand-blot-white-background-realistic-vector-illustration_37917104.htm#fromView=search&page=1&position=0&uuid=6fe9eee1-a19c-41b4-ad21-3fccbd2888c2&query=ghost+hand">Image by macrovector on Freepik</a>
<a href="https://www.freepik.com/free-vector/flat-design-bloody-handprint-background_66188147.htm#fromView=search&page=1&position=2&uuid=7b21e5f2-03a2-48a8-81f7-b5287074f38c&query=scary+print">Image by freepik</a>

# Disclaimer
This project may not be the most optimal solution for a UV light effect, but it might still be useful or serve as a starting point to build upon.
