// bootstrap-ckeditor-fix.js
// hack to fix ckeditor/bootstrap compatiability bug when ckeditor appears in a bootstrap modal dialog
//
// Include this file AFTER both jQuery and bootstrap are loaded.
$.fn.modal.Constructor.prototype.enforceFocus = function() {
  alert('implementing fix');
  modal_this = this;
  alert(modal_this);
  $(document).on('focusin.modal', function (e) {
    if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length 
    && $(e.target.parentNode).hasClass('cke_contents cke_reset')) {
      modal_this.$element.focus();
    }
  })
};