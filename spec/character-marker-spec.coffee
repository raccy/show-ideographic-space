CharacterMarker = require '../lib/character-marker'

describe "CharacterMarkerSpace", ->
  cm = undefined

  beforeEach ->
    charMap =
      '　':
        type: "overlay"
        class: "ideographic-space"
    cm = new CharacterMarker charMap

  describe "CharacterMarker#setCharDecoration()", ->
    it "set", ->
      decoration = {type: "overlay", class: "hoge"}
      expect(cm.setCharDecoration('あ', decoration)).toEqual(decoration)

  describe "CharacterMarker#getCharDecoration()", ->
    it "get ideographic space", ->
      decoration =
        type: "overlay"
        class: "ideographic-space"
      expect(cm.getCharDecoration('　')).toEqual(decoration)

    it "get none", ->
      expect(cm.getCharDecoration('い')).toEqual(undefined)

  describe "CharacterMarker#deleteCharDecoration()", ->
    it "delete ideographic space", ->
      expect(cm.deleteCharDecoration('　')).toEqual(true)
      expect(cm.getCharDecoration('　')).toEqual(undefined)

  describe "CharacterMarker#checkText()", ->
    it "checkText ideographic space", ->
      expect(cm.checkText('ほげ　ふが')).toEqual(true)
      expect(cm.checkText('ほげふが')).toEqual(false)

  describe "CharacterMarker#handleMark()", ->
    it "handleMark", ->
      expect(cm.handleMark()).toEqual(undefined)
