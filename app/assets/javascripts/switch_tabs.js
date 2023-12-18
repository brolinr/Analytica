document.addEventListener('turbo:load', function() {
  let next_button = document.getElementById('next-button');
  let previous_button = document.getElementById('previous-button')

  let documents_tab = document.getElementById('documents');
  let documents_button = document.getElementById('documents-tab')

  let company_details_tab = document.getElementById('company-details');
  let company_details_button = document.getElementById('company-details-tab')

  next_button.addEventListener('click', function() {
    switch_tabs(company_details_tab, company_details_button, documents_tab, documents_button);
  });

  previous_button.addEventListener('click', function() {
    switch_tabs(documents_tab, documents_button, company_details_tab, company_details_button);
  });

  function switch_tabs(active_tab, active_button, faded_tab, faded_button) {
    active_tab.classList.remove('show', 'active')
    active_button.classList.remove('active')
    active_button.ariaSelected = 'false'
    active_button.tabIndex = -1

    faded_tab.classList.add('active', 'show')
    faded_button.classList.add('active')
    faded_button.ariaSelected = 'true'
    faded_button.removeAttribute('tabIndex')
  }
});