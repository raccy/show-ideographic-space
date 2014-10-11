ShowIdeographicSpaceManager = require './show-ideographic-space-manager'

module.exports =
  config:
    InvisibleIdeographicSpace:
      type: "string"
      default: "□"
    ShowIdeographicSpace:
      type: "boolean"
      default: true

  showIdeographicSpaceView: null

  activate: (state) ->
    @showIdeographicSpaceManager = new ShowIdeographicSpaceManager
    atom.workspaceView.eachEditorView (editorView) =>
      @showIdeographicSpaceManager.overwriteTokenizedBuffer(editorView.getModel())

  deactivate: ->
    atom.workspaceView.eachEditorView (editorView) =>
      @showIdeographicSpaceManager.restoreTokenizedBuffer(editorView.getModel())
