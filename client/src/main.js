import { createApp } from 'vue';
import App from './App.vue';
import router from './router';

import 'bootstrap/dist/css/bootstrap.css'
import bootstrap from 'bootstrap/dist/js/bootstrap.js'

import PrimeVue from 'primevue/config';
import Rating from 'primevue/rating';
import Textarea from 'primevue/textarea';
import Dropdown from 'primevue/dropdown';
import InputText from 'primevue/inputtext';
import FloatLabel from 'primevue/floatlabel';
import Listbox from 'primevue/listbox';
import MultiSelect from 'primevue/multiselect';

import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import ColumnGroup from 'primevue/columngroup';   // optional
import Row from 'primevue/row';                   // optional

// import Button from 'primevue/button';
// import InputText from 'primevue/inputtext';

import 'primevue/resources/themes/saga-blue/theme.css'; // Theme
import 'primevue/resources/primevue.min.css';           // Core CSS
import 'primeicons/primeicons.css';                     // Icons
import 'primeflex/primeflex.css';  

import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

library.add(fas);

createApp(App)
  .use(router)
  .use(bootstrap)
  .use(PrimeVue)
  .component('Rating', Rating)
  .component('Textarea', Textarea)
  .component('Dropdown', Dropdown)
  .component('InputText', InputText)
  .component('FloatLabel', FloatLabel)
  .component('Listbox', Listbox)
  .component('MultiSelect', MultiSelect)
  .component("DataTable", DataTable)
  .component("Column", Column)
  .component("ColumnGroup", ColumnGroup)
  .component("Row", Row)
  .component("fa", FontAwesomeIcon)

  .mount('#app');
