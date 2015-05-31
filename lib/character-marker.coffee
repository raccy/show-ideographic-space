{Range, Point} = require 'atom'

module.exports =
class CharacterMarker
  constructor: (@charMap) ->
    @markerList = []

  destroy: ->
    @removeMark()

  setCharDecoration: (char, decoration) ->
    @charMap[char] = decoration

  getCharDecoration: (char) ->
    if char of @charMap
      return @charMap[char]
    else
      return undefined

  deleteCharDecoration: (char) ->
    if char of @charMap
      delete @charMap[char]

  checkText: (text) ->
    for char of @charMap
      if text.includes char
        return true
    return false

  handleMark: ->
    @removeMark()
    for key, value of @charMap
      @mark key, value
    return

  mark: (char, decoration) ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?
    range = new Range(new Point(0, 0), editor.getEofBufferPosition())

    editor.scanInBufferRange @creatRegExpEscaped(char), range, (result) =>
      console.log(result.matchText)
      marker = editor.markBufferRange result.range
      editor.decorateMarker marker, decoration
      @markerList.push marker

  removeMark: ->
    for marker of @markerList
      if marker.destroy?
        marker.destroy()
    @markerList = []

  creatRegExpEscaped: (s) ->
    new RegExp s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')
