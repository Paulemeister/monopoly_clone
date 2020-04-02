# monopoly_clone
Attempt of replicating Monopoly with Godot

# Changelog
### Version 1.2
- Finally got the resizing problem fixed.
- Added a custom container, that resizes it's children to it's own size
- Started to work on on live size change of the font to match the size of the field
### Version 1.3
- Replaced custom container with MarginContainers
- Realtime font resizing added
- Realtime text updating added
- Finished realtime resizable board grid
### Version 1.4
- Added function that returns the field  that a given number is in
- Added a Main Scene
- Noticed a bug with the resizing of containers of a Board instance, when another Field Instance, that has bigger x dimensions than the Board instance, is in the same Scene
### Version 1.5
- Added players
- Added gamelogic
- Added pausing/unpausing of the game
- started to work on base class for fields to inherit from
### Version 1.6
- Started Transition to 3D Board
- Switched to using Classes and no instanced scenes
- added little wobble animation for indivisual fields
- All 3D Classes have proper inheritance
## What I learned
Godot has some weird quirks that I had to work around to make things work. Sometimes only countless hours of reading forums led me to the answer and sometimes I just overlooked that:
- eventhough the editor lets you input colors with rgb values from 0 to 255, in actuallity they ae stored as floats from 0 to 100, with 0 to 1 being the actual colorspace 
- After adding a DirectionalLight and enabeling shadows you first have to rotate the node to actually get shadows
- Adding Nodes by script does not make them show up in the editor window. Solution?
  - Setting the owner of the Node adding Nodes, to the parents owner with set_owner(), which is not documented. Except when the parent is the Root Node: then set the owner to that node, cause it doesn't have an owner.
  - Just setting the owner to a nodes parent will not make them show up after the childs child
  - Not setting an owner of a Node added through script will leave it with null as its owner
- You can add your own Classes through the editor after setting it's name with node_name ClassName
- Adding a Font to different Labels will make them share it, so changing the font size will affect all of the Labels
  - Solution: make them unique with Make Unique inside the editor or use font = font.duplicate() (according to an issue on github)
- You get the font of a Label with $Label.get("custom_font/font")
- ControlNodes don't automatically resize to it's parents size, MarginContainers with all of the custom_constants set to 0 will do that
- The only way to have a Container resize its children with a percentual margin/space inbetween is to add an emmpty node and fiddling around with size_flags_strech_ratio
- For whatever reason the syntax for getting a random integer i with a≤i≤b is var i: int = randi()%(b-a+1)+a
# Reddit
Solved my problem, would appreciate advice though
