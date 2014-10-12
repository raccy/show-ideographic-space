module.exports =
class ShowIdeographicSpaceManager
  constructor: ->
    @showIdeographicSpace = true
    @invisibleIdeographicSpace = '□'
    @ideographicSpace = '\u3000' # U+3000

  # overwrite TokenizedBuffer#buildPlaceholderTokenizedLineForRow()
  overwriteTokenizedBuffer: (edtior) ->
    tokenizedBuffer = edtior.displayBuffer.tokenizedBuffer
    unless tokenizedBuffer.showIdeographicSpaceManager?
      tokenizedBuffer.showIdeographicSpaceManager = @

    unless tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow?
      tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow =
          tokenizedBuffer.buildPlaceholderTokenizedLineForRow

    #buildTokenizedTokenizedLineForRow
    unless tokenizedBuffer.originalBuildTokenizedTokenizedLineForRow?
      tokenizedBuffer.originalBuildTokenizedTokenizedLineForRow =
          tokenizedBuffer.buildTokenizedTokenizedLineForRow

    tokenizedBuffer.buildPlaceholderTokenizedLineForRow = (row) ->
      tokenizedLine = @originalBuildPlaceholderTokenizedLineForRow(row)
      if @showIdeographicSpaceManager.showIdeographicSpace
        tokenizedLine =
            @showIdeographicSpaceManager.tokenizedTokenizedLine(tokenizedLine)
      # TODO: 動いているところを見たことが無い
      console.log("overwritedBuildPlaceholderTokenizedLineForRow")
      return tokenizedLine

    tokenizedBuffer.buildTokenizedTokenizedLineForRow = (row, ruleStack) ->
      tokenizedLine = @originalBuildTokenizedTokenizedLineForRow(row, ruleStack)
      if @showIdeographicSpaceManager.showIdeographicSpace
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
    # こいつに"　"があるかどうかで処理を変える
    if tokenizedLine.text.contains(@ideographicSpace)
      console.log("include spaces: " + tokenizedLine.text)
      console.log(tokenizedLine)

      tokens = tokenizedLine.tokens
      # TODO: がんばると
      lineEnding = tokenizedLine.lineEnding
      ruleStack = tokenizedLine.ruleStack
      startBufferColumn = tokenizedLine.startBufferColumn
      fold = tokenizedLine.fold
      tabLength = tokenizedLine.tabLength
      indentLevel = tokenizedLine.indentLevel
      invisibles = tokenizedLine.invisibles

      ClassTokenizedLine = tokenizedLine.prototype
      console.log(ClassTokenizedLine)
      #console.log(ClassTokenizedLine.constructor)
      #console.log()
      #tokenLine = new ClassTokenizedLine({tokens, @lineEnding, @ruleStack, @startBufferColumn, @fold, @tabLength, @indentLevel, @invisibles})
      #console.log(tokenizedLine)
      #new TokenizedLine({tokens, tabLength, indentLevel, @invisibles, lineEnding})

      return tokenizedLine
    else
      return tokenizedLine
