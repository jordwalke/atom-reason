AtomReasonView = require './atom-reason-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomReason =
  atomReasonView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomReasonView = new AtomReasonView(state.atomReasonViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomReasonView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-reason:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomReasonView.destroy()

  serialize: ->
    atomReasonViewState: @atomReasonView.serialize()

  toggle: ->
    console.log 'AtomReason was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
