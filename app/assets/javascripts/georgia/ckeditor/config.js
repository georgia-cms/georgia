CKEDITOR.config.basePath = '/assets/ckeditor/'
CKEDITOR.config.ignoreEmptyParagraph = false;
CKEDITOR.config.allowedContent = true;
CKEDITOR.config.height = 400;
CKEDITOR.config.width = '95.5%';
CKEDITOR.config.toolbarStartupExpanded = false;
CKEDITOR.config.toolbarGroups = [
  { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
  { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
  { name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ] },
  '/',
  { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
  { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ] },
  { name: 'links' },
  { name: 'insert' },
  '/',
  { name: 'styles' },
  { name: 'colors' },
  { name: 'tools' },
  { name: 'others' }
];