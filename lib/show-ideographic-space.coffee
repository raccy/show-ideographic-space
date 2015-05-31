{CompositeDisposable} = require 'atom'

# ShowIdeographicSpaceManager = require './show-ideographic-space-manager'
CharacterMarker = require './character-marker'

module.exports =
  config:
    InvisibleIdeographicSpace:
      type: 'string'
      default: '□'
    ShowIdeographicSpace:
      type: 'boolean'
      default: true

  characterMarker: null

  activate: (state) ->
    # @showIdeographicSpaceManager = new ShowIdeographicSpaceManager
    # @showIdeographicSpaceManager.overwriteTokenizedBuffer(editor)
    charMap = {
      '　':
        type: 'highlight'
        class: 'ideographic-space'
    }
    @characterMarker = new CharacterMarker charMap
    @subscriptions = new CompositeDisposable

    atom.workspace.observeTextEditors (editor) =>
      @subscriptions.add editor.onDidInsertText (event) =>
        if @characterMarker.checkText(event.text)
          @characterMarker.handleMark()

    @subscriptions.add atom.commands.add 'atom-workspace', 'show-ideographic-space:toggle': => @toggle()

    # @subscriptions.add atom.config.observe 'niconico.cookieStoreFile',
    #   (newValue) =>
    #     @niconicoView.setCookieStoreFile newValue



  deactivate: ->
    # atom.workspace.observeTextEditors (editor) =>
    #   @showIdeographicSpaceManager.restoreTokenizedBuffer(editor)
    @characterMarker.destroy()
    @subscriptions.dispose()

  toggle: ->
    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
