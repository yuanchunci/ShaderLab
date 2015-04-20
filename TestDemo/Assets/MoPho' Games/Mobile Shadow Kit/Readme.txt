MOBILE SHADOW TOOLKIT - v1.0
This toolkit will help you to add realistic shadows to your mobile game, it will wow and amaze the gamers who play your game, and it's super easy to set up!

PT1 - Quick Start
To quickly get started, we're going to recreate the TestScene included with the package.
First, create a few primitives in your scene, on top of a Plane for the floor. Then, to each of these, assign the MoPho' Games -> Mobile Shadow Kit -> Example -> ShadowReceiver material to each of them. Don't worry that the scene looks very dark, it will look fine when you Play the game.
Now create a directional light, and add Components -> Mobile Shadow Kit -> Shadow Manager.
Set the shadow map size to 2048, and the shadow map coverage to 20.
Now click Play. Go ahead and move around some of the shapes to see that, indeed, the shadows are fully dynamic.

PT2 - How it works
The shadow manager script is what drives everything. It creates a camera that renders RGBA-encoded depth into a shadow map, and then it provides several values as global shader variables so that all shaders can access them:
_ShadowProjectionMatrix: multiply your vertices by _Object2World and then this matrix, to transform them into shadowmap space.
_ShadowMapTex: this is the actual shadowmap texture. Per-pixel, you can get the encoded depth using the DecodeFloatRGBA function and then compare that with the fragment's distance to the light (see the included ShadowReceiver.shader file for an example of how this is done)
_InvShadowMapTexSize: This is the inverse size in pixels of the shadowmap (1/shadowmapsize)
_ShadowMapCoverage: This is the size in meters that the shadow map covers

Most of the time, you will only need the shadowmap texture, the projection matrix, and the coverage (this is used for distance clipping to avoid stretching artifacts when objects move outside of the shadowmap)
For an example of how to write a shader that uses the shadowmapping system, please see the included ShadowReceiver.shader. It uses the standard Surface Shader / Lighting Model system, which should make it pretty easy to modify or adapt for most shaders you will use in your game.

PT3 - Limitations and Best Practice
As with Unity 4 shadows, this will only work on directional lights. Additionally you can only have a single shadowmap at a time.
There are also no cascades in this system. Essentially, it has many of the same limitations of Unity 4 Mobile shadows, meaning aliasing is particularly visible.
How do you get around this?
Well, here's what I suggest for best results with this system:
* Lightmap your levels, don't use shadowmapping to shade them. They will look far better lightmapped.
* Put your characters on a special layer set to not render into the shadowmap (on the ShadowManager, uncheck that layer from the Shadow Casting Layers)
* Since your characters no longer cast shadows, you could use some kind of projected shadow system ala PS2/Xbox era shadows (although it's still used in games to this day, such as in Left 4 Dead)
* Since characters at a distance will be clipped against the shadows (will look fully lit), you could write a custom shader that enables Spherical Harmonics (light probe) rendering at a distance so that characters at a distance are basically just color tinted, and characters close up use shadowmapping.
* Enable sparse rendering of your shadowmap. You'll set the Distance Threshold (how far the camera has to move before updating the shadowmap, this should be less than or equal to half of the coverage), and check the Sparse Update checkbox. This means the shadowmap will not be rendered every frame, saving on performance.

There's another quirk of this system, which you might notice...
"Where's the bias value??"
There is no bias in my shadow mapping system. None at all. How do I get away with zero bias without the dreaded moire effect?
Because I decided that front faces would not cast shadows at all.
Instead, from the point of view of the light, I decided to cull all of the front faces and only render the back faces into the shadowmap. Since the back faces are usually already mapped to 0 in the lighting model (Lambert in most cases), this means I do not need to add any bias since there are no artifacts (and that means I can avoid the Peter Pan effect altogether, where the shadow floats away from the caster). This does mean, of course, that objects without backfaces (such as a plane that faces the light) will not cast any shadows.