{WorkspaceView} = require 'atom'
ShowIdeographicSpace = require '../lib/show-ideographic-space'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ShowIdeographicSpace", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('show-ideographic-space')

  describe "when the show-ideographic-space:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.show-ideographic-space')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'show-ideographic-space:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.show-ideographic-space')).toExist()
        atom.workspaceView.trigger 'show-ideographic-space:toggle'
        expect(atom.workspaceView.find('.show-ideographic-space')).not.toExist()
