{path} = require './common'

# Given an image named `testimage.*` we want to create 3 variants
# - `large` -> testimage.png: with a width of 500px
# - `medium` -> testimage._SL160_.png: with a width of 160px
# - `small` -> testimage._SL75_.png: with a width of 75px

extSplit = (fileName) ->
  fileName = fileName.split('.')
  ext = fileName.pop()
  fileNameNoExt = fileName.join('.')
  [ext, fileNameNoExt]

isNotAnOriginal = (key) ->
  # Is the current file the original or one of the generated variants ?
  # This is used to skip files that should not be re-converted
  tokens = ["_SL75_.png", "_SL160_.png"]
  for token in tokens
    if key.indexOf(token) != -1
      return true
  false

generateVariants = (key) ->
  fileName = path.basename(key)
  [originalExt, originalName] = extSplit(fileName)
  ext = "png"
  result =
    large:
      key: "#{originalName}.#{ext}"
      width: 500
    medium:
      key: "#{originalName}._SL160_.#{ext}"
      width: "160"
    small:
      key: "#{originalName}._SL75_.#{ext}"
      width: "75"
  result


module.exports = {generateVariants, isNotAnOriginal}


if not module.parent
  console.log "teSt.png => ", JSON.stringify(template("teSt.png"), null, 2)