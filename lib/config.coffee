module.exports =

  apply: () ->

    body = document.querySelector('body')


    # functions

    applyFont = (font) ->
      body.setAttribute('data-isotope-light-ui-font', font)

    applyFontWeight = (weight) ->
      body.setAttribute('data-isotope-light-ui-fontweight', weight)

    applyBackgroundGradient = () ->
      if atom.config.get('isotope-light-ui.backgroundGradient')
        body.setAttribute('data-isotope-light-ui-bg-gradient', 'true')
        atom.config.set('isotope-light-ui.backgroundImage', 'false')
      else
        body.setAttribute('data-isotope-light-ui-bg-gradient', 'false')

    applyBackgroundImage = () ->
      if atom.config.get('isotope-light-ui.backgroundImage')
        atom.config.set('isotope-light-ui.customBackgroundColor', 'false')
        atom.config.set('isotope-light-ui.backgroundGradient', 'false')
        body.setAttribute('data-isotope-light-ui-bg-image', 'true')
        body.style.backgroundImage =
          'url(' + atom.config.get('isotope-light-ui.backgroundImagePath') + ')'
      else
        body.setAttribute('data-isotope-light-ui-bg-image', 'false')
        body.style.backgroundImage = ''

    applyTooltipContrast = () ->
      if atom.config.get('isotope-light-ui.lowContrastTooltip')
        body.setAttribute('data-isotope-light-ui-tooltip-lowcontrast', 'true')
      else
        body.setAttribute('data-isotope-light-ui-tooltip-lowcontrast', 'false')

    applyEditorFont = () ->
      if atom.config.get('isotope-light-ui.matchEditorFont')
        if atom.config.get('editor.fontFamily') is ''
          body.style.fontFamily = 'Inconsolata, Monaco, Consolas, "Courier New", Courier'
        else
          body.style.fontFamily = atom.config.get('editor.fontFamily')
      else
        body.style.fontFamily = ''

    applySpaciousMode = () ->
      if atom.config.get('isotope-ui.spaciousMode')
        body.setAttribute('data-isotope-ui-spacious', 'true')
      else
        body.setAttribute('data-isotope-ui-spacious', 'false')


    # run when atom is ready
    applyFont(atom.config.get('isotope-light-ui.fontFamily'))
    applyFontWeight(atom.config.get('isotope-light-ui.fontWeight'))
    applyBackgroundGradient()
    applyBackgroundImage()
    applyTooltipContrast()
    applyEditorFont()
    applySpaciousMode()


    # run when configs change

    atom.config.onDidChange 'isotope-light-ui.fontFamily', ->
      applyFont(atom.config.get('isotope-light-ui.fontFamily'))

    atom.config.onDidChange 'isotope-light-ui.fontWeight', ->
      applyFontWeight(atom.config.get('isotope-light-ui.fontWeight'))

    atom.config.onDidChange 'isotope-light-ui.backgroundGradient', ->
      applyBackgroundGradient()

    atom.config.onDidChange 'isotope-light-ui.backgroundImage', ->
      applyBackgroundImage()

    atom.config.onDidChange 'isotope-light-ui.backgroundImagePath', ->
      applyBackgroundImage()

    atom.config.onDidChange 'isotope-light-ui.lowContrastTooltip', ->
      applyTooltipContrast()

    atom.config.onDidChange 'isotope-light-ui.matchEditorFont', ->
      applyEditorFont()

    atom.config.onDidChange 'isotope-ui.spaciousMode', ->
      applySpaciousMode()

    atom.config.onDidChange 'editor.fontFamily', ->
      applyEditorFont()
