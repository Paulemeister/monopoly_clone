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
# Reddit
Solved my problem, would appreciate advice though
