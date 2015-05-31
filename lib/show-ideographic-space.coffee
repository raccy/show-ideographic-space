{CompositeDisposable} = require 'atom'

CharacterMarker = require './character-marker'

module.exports =
  characterMarker: null
  name: 'show-ideographic-space'

  activate: (state) ->
    charMap = {
      '　':
        type: 'highlight'
        class: 'ideographic-space'
    }
    @characterMarker = new CharacterMarker charMap
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      if @characterMarker.checkText(editor.getText())
        @characterMarker.handleMark(editor, @name)
      @subscriptions.add editor.onDidInsertText (event) =>
        if @characterMarker.checkText(event.text)
          @characterMarker.handleMark(editor, @name)

  deactivate: ->
    for editor in atom.workspace.getTextEditors
      @characterMarker editor, @name
    @characterMarker.destroy()
    @subscriptions.dispose()
