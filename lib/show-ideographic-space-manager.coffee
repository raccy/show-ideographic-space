module.exports =
class ShowIdeographicSpaceManager
  constructor: ->
    @showIdeographicSpace =
      atom.config.get('show-ideographic-space.ShowIdeographicSpace')
    @invisibleIdeographicSpace =
      atom.config.get('show-ideographic-space.InvisibleIdeographicSpace')
    @showInvisibles = atom.config.get('editor.showInvisibles')
    @ideographicSpace = '\u3000' # IDEOGRAPHIC SPACE U+3000
    atom.config.observe 'show-ideographic-space.ShowIdeographicSpace', (newValue) =>
      @showIdeographicSpace = newValue
    atom.config.observe 'show-ideographic-space.InvisibleIdeographicSpace', (newValue) =>
      @invisibleIdeographicSpace = newValue
    atom.config.observe 'editor.showInvisibles', (newValue) =>
      @showInvisibles = newValue

  # overwrite TokenizedBuffer#buildPlaceholderTokenizedLineForRow()
  overwriteTokenizedBuffer: (edtior) ->
    tokenizedBuffer = edtior.displayBuffer.tokenizedBuffer
    unless tokenizedBuffer.showIdeographicSpaceManager?
      tokenizedBuffer.showIdeographicSpaceManager = @

    unless tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow?
      tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow =
          tokenizedBuffer.buildPlaceholderTokenizedLineForRow

    #buildTokenizedLineForRow
    unless tokenizedBuffer.originalBuildTokenizedLineForRow?
      tokenizedBuffer.originalBuildTokenizedLineForRow =
          tokenizedBuffer.buildTokenizedLineForRow

    # TODO: not need?
    tokenizedBuffer.buildPlaceholderTokenizedLineForRow = (row) ->
      tokenizedLine = @originalBuildPlaceholderTokenizedLineForRow(row)
      if @showIdeographicSpaceManager.showInvisibles and
          @showIdeographicSpaceManager.showIdeographicSpace
        tokenizedLine =
            @showIdeographicSpaceManager.tokenizedTokenizedLine(tokenizedLine)
      return tokenizedLine

    tokenizedBuffer.buildTokenizedLineForRow = (row, ruleStack) ->
      tokenizedLine = @originalBuildTokenizedLineForRow(row, ruleStack)
      if @showIdeographicSpaceManager.showInvisibles and
          @showIdeographicSpaceManager.showIdeographicSpace
        tokenizedLine =
            @showIdeographicSpaceManager.tokenizedTokenizedLine(tokenizedLine)
      return tokenizedLine

  # restore TokenizedBuffer#buildPlaceholderTokenizedLineForRow()
  restoreTokenizedBuffer: (edtior) ->
    tokenizedBuffer = edtior.displayBuffer.tokenizedBuffer
    if tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow?
      tokenizedBuffer.buildPlaceholderTokenizedLineForRow =
          tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow
      tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow = undefined

    if tokenizedBuffer.showIdeographicSpaceManager?
      tokenizedBuffer.showIdeographicSpaceManager = undefined

  tokenizedTokenizedLine: (tokenizedLine) ->
    if tokenizedLine.text.contains(@ideographicSpace)
      # console.log(tokenizedLine)
      newTokens = []
      oldTokens = tokenizedLine.tokens
      for token in oldTokens
        while (i = token.value.indexOf(@ideographicSpace)) != -1
          modTokens = token.splitAt(i)
          leftToken = modTokens[0]
          token = modTokens[1]
          modTokens = token.splitAt(1)
          middleToken = modTokens[0]
          token = modTokens[1]
          newTokens.push(leftToken)
          #middleToken.hasInvisibleCharacters = true
          if not middleToken.scopes?
            middleToken.scopes = []
          middleToken.scopes = middleToken.scopes.concat(
              "ideographic-space.invisible-character")
          middleToken.value = @invisibleIdeographicSpace
          newTokens.push(middleToken)
          hasIndentGuide = false
        newTokens.push(token)
      tokens = newTokens

      lineEnding = tokenizedLine.lineEnding
      ruleStack = tokenizedLine.ruleStack
      startBufferColumn = tokenizedLine.startBufferColumn
      fold = tokenizedLine.fold
      tabLength = tokenizedLine.tabLength
      indentLevel = tokenizedLine.indentLevel
      invisibles = tokenizedLine.invisibles

      tokenizedLine = new tokenizedLine.__proto__.constructor({
            tokens, lineEnding, ruleStack, startBufferColumn, fold,
            tabLength, indentLevel, invisibles})
      # console.log(tokenizedLine)
    return tokenizedLine
