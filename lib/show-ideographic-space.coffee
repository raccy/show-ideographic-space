#ShowIdeographicSpaceView = require './show-ideographic-space-view'
#LinesComponent = require '/Applications/Atom.app/Contents/Resources/app/src/lines-component'
#aattoomm = require 'atom'
module.exports =
  config:
    InvisibleIdeographicSpace:
      type: "string"
      default: "□"
    ShowIdeographicSpace:
      type: "boolean"
      default: true
  #showIdeographicSpaceView: null

  activate: (state) ->
    #console.log(LinesComponent.prototypes.buildLineHTML)
    atom.workspaceView.eachEditorView (editorView) =>
      model = editorView.getModel()
      #model.displayBuffer.tokenizedBuffer.tokenizedLines[0].tokens[0].value = 'ほげ'
      #console.log(model.displayBuffer.tokenizedBuffer.buildPlaceholderTokenizedLineForRow)
      #console.log(model.displayBuffer.tokenizedBuffer.tokenizedLines)
      console.log(model.displayBuffer.tokenizedBuffer.grammar)
    #console.log(aattoomm)
    #atom.workspaceView.eachEditorView (editorView) ->
    #  html_rep = editorView.find(".line.cursor-line").html().replace('　', '<span class="invisible-character">□</span>' )
      #editorView.find(".line.cursor-line").html(html_rep)
      #editorView.html(html_rep)
    #  console.log(html_rep)
    # 前　全角
    #console.log(atom.config.get('editor.invisibles'))
    #@showIdeographicSpaceView = new ShowIdeographicSpaceView(state.showIdeographicSpaceViewState)

  deactivate: ->
    #@showIdeographicSpaceView.destroy()

  #serialize: ->
    #showIdeographicSpaceViewState: @showIdeographicSpaceView.serialize()
