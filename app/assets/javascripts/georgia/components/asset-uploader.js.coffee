# We use fileuploadalways callback because the response from the server is not accepted as successful
# See other callbacks here: https://github.com/blueimp/jQuery-File-Upload/wiki/Options#callback-options
class @AssetUploader

  constructor: (element, options={}) ->
    @el = $(element)
    @btn = @el.prev()
    @progress = $('#progress')
    @progressBar = $('#progress .progress-bar')
    @bindEvents()

  bindEvents: () =>
    @el.fileupload(dataType: 'jsonp')
    # @el.on('fileuploadadd', @fileuploadadd)
    @el.on('fileuploadsend', @fileuploadsend)
    @el.on('fileuploadalways', @fileuploadalways)
    @el.on('fileuploadprogressall', @fileuploadprogressall)

  fileuploadadd: (e, data) -> data.submit()

  fileuploadsend: (e, data) =>
    @btn.html("<i class='fa fa-spinner fa-spin'></i> Uploading...")
    @progress.modal('show')

  fileuploadalways: (e, data) =>
    @progress.modal('hide')
    @btn.html("<i class='fa fa-check'></i> Uploaded")
    setTimeout(
      -> @btn.html("<i class='fa fa-plus'></i> Select files...")
      1500
    )

  fileuploadprogressall: (e, data) =>
    progress = parseInt(data.loaded / data.total * 100, 10)
    @progressBar
      .css('width', "#{progress}%")
      .attr('aria-valuenow', "#{progress}%")

$.fn.uploadable = ->
  @each ->
    new AssetUploader(this)

jQuery ->
  $('.js-file-upload').uploadable()