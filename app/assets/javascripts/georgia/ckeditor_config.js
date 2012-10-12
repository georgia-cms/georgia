CKEDITOR.config.baseHref = '/assets/ckeditor/';
CKEDITOR.config.height = 400;
// CKEDITOR.config.toolbarStartupExpanded = false;
CKEDITOR.config.toolbar = 'Full';
CKEDITOR.config.toolbar_Full =
[
	{ name: 'document', items : [ 'Source','-','ShowBlocks'] },
	{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
	{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
	{ name: 'tools', items : [ 'Maximize' ] },
	{ name: 'links', items : [ 'Link','Unlink' ] },
	{ name: 'colors', items : [ 'TextColor','BGColor' ] },
	{ name: 'insert', items : [ 'Image','HorizontalRule','SpecialChar','PageBreak' ] },
	'/',
	{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
	{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] }
];