module.exports =
class ShowIdeographicSpaceManager
  constructor: ->
    #

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
      originalTokenizedLines = @originalBuildPlaceholderTokenizedLineForRow(row)
      # TODO(raccy): 実装すること
      console.log("overwritedBuildPlaceholderTokenizedLineForRow")
      console.log(originalTokenizedLines)
      return originalTokenizedLines

    tokenizedBuffer.buildTokenizedTokenizedLineForRow = (row, ruleStack) ->
      originalTokenizedLines = @originalBuildTokenizedTokenizedLineForRow(row, ruleStack)
      # TODO(raccy): 実装すること
      # あああ　あああ
      console.log("overwritedBuildTokenizedTokenizedLineForRow")
      console.log(originalTokenizedLines)
      return originalTokenizedLines

    #console.log(tokenizedBuffer.buildPlaceholderTokenizedLineForRow)



  # restore TokenizedBuffer#buildPlaceholderTokenizedLineForRow()
  restoreTokenizedBuffer: (edtior) ->
    tokenizedBuffer = edtior.displayBuffer.tokenizedBuffer
    if tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow?
      tokenizedBuffer.buildPlaceholderTokenizedLineForRow =
          tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow
      tokenizedBuffer.originalBuildPlaceholderTokenizedLineForRow = undefined

    if tokenizedBuffer.showIdeographicSpaceManager?
      tokenizedBuffer.showIdeographicSpaceManager = undefined
