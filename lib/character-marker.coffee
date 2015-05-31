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

  handleMark: (editor, rel) ->
    for marker in editor.findMarkers(rel: rel)
      marker.destroy()
    for char, decoration of @charMap
      @mark editor, rel, char, decoration
    return

  mark: (editor, rel, char, decoration) ->
    range = new Range(new Point(0, 0), editor.getEofBufferPosition())
    editor.scanInBufferRange @creatRegExpEscaped(char), range, (result) ->
      marker = editor.markBufferRange result.range
      marker.setProperties(rel: rel)
      editor.decorateMarker marker, decoration

  creatRegExpEscaped: (s) ->
    new RegExp s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'
