ShowIdeographicSpaceManager = require './show-ideographic-space-manager'

module.exports =
  config:
    InvisibleIdeographicSpace:
      type: 'string'
      default: '□'
    ShowIdeographicSpace:
      type: 'boolean'
      default: true
      description: 'To activate this setting, you need to enable the "Show Invisibles" in the "Settings".'

  showIdeographicSpaceView: null

  activate: (state) ->
    @showIdeographicSpaceManager = new ShowIdeographicSpaceManager
    atom.workspaceView.eachEditorView (editorView) =>
      @showIdeographicSpaceManager.overwriteTokenizedBuffer(editorView.getModel())

  deactivate: ->
    atom.workspaceView.eachEditorView (editorView) =>
      @showIdeographicSpaceManager.restoreTokenizedBuffer(editorView.getModel())
